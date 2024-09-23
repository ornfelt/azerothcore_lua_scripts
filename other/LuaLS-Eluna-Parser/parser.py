import os
import sys
from bs4 import BeautifulSoup

def extract_method_info(soup):
    method_section = soup.find('h1')
    class_name_tag = method_section.find_next()
    class_name = class_name_tag.text.strip()
    method_string_tag = class_name_tag.find_next_sibling()
    method_string = method_string_tag.text.strip()
    return class_name, method_string

def extract_class_and_inheritance(soup):
    main_section = soup.find('section', id='main', class_='content mod')
    if main_section is None:
        return None, []
    
    h1_tag = main_section.find('h1', class_='fqn')
    if h1_tag is None:
        return None, []
    
    # Extract class name from the h1 tag
    class_name = h1_tag.find('a', class_='mod').text.strip()
    
    # Find the <p> tag containing inheritance information
    inheritance_p_tag = None
    for p_tag in main_section.find_all('p', recursive=False):
        if p_tag.get_text(strip=True).startswith('Inherits all methods from:'):
            inheritance_p_tag = p_tag
            break
    
    if inheritance_p_tag is None:
        return class_name, []
    
    # Extract inherited objects from the <p> tag
    inherited_objects = [a_tag.text.strip() for a_tag in inheritance_p_tag.find_all('a', class_='mod')]
    return class_name, inherited_objects
    
def extract_arguments(soup):
    arguments_section = soup.find('h2', id='arguments')
    if arguments_section is None:
        return []
    
    arguments_p_tag = arguments_section.find_next_sibling('p')
    if arguments_p_tag is None:
        return []
    
    dl_elements = arguments_p_tag.find_all('dl')
    if not dl_elements:
        return []
    
    arguments_list = []
    for dl in dl_elements:
        dt_element = dl.find('dt')
        if dt_element is None:
            continue
        
        argument_type = dt_element.find('a')
        if argument_type is None:
            continue
        
        argument_type = argument_type.text.strip()
        
        argument_name = dt_element.text.replace(argument_type, '').strip()
        argument_name, argument_optional, argument_optional_value = extract_argument_name_opt(argument_name)
        
        # special case for function arguments
        if argument_type == "function":
            argument_name = "func"
        
        # special cases where vararg is used
        if argument_type == "...":
            argument_name = "..."
            argument_type = "any"
        
        # special case where argument name was reserved type
        if argument_name == "repeat":
            argument_name = "setRepeat"
        
        argument_description = dl.find('dd', class_='docblock')
        if argument_description:
            argument_description = argument_description.text.strip()
        else:
            argument_description = ""
        
        if argument_description == "See method description.":
            argument_description = ""
        
        arguments_list.append({'type': argument_type, 'name': argument_name, 'description': argument_description, 'optional': argument_optional, 'optional_val': argument_optional_value})
    return arguments_list

def extract_argument_name_opt(argument_name):
    parts = argument_name.split(' (')
    argument_name = parts[0].strip()
    argument_optional = False
    argument_optional_value = None
    if len(parts) > 1:
        optional_part = parts[1].strip()
        if optional_part.endswith(')'):
            optional_part = optional_part[:-1]  # Remove the closing bracket
        if optional_part.lower() == 'optional':
            argument_optional = True
        else:
            argument_optional = True
            argument_optional_value = optional_part
    return argument_name, argument_optional, argument_optional_value

def extract_return_values(soup):
    returns_section = soup.find('h2', id='returns')
    if returns_section is None:
        return []
    
    returns_p_tag = returns_section.find_next_sibling('p')
    if returns_p_tag is None:
        return []
    
    dl_elements = returns_p_tag.find_all('dl')
    if not dl_elements:
        return []
    
    return_values_list = []
    for dl in dl_elements:
        dt_element = dl.find('dt')
        if dt_element is None:
            continue
        
        return_type = dt_element.find('a')
        if return_type is None:
            continue
        
        return_type = return_type.text.strip()
        
        return_name = dt_element.text.replace(return_type, '').strip()
        return_description = dl.find('dd', class_='docblock')
        if return_description:
            return_description = return_description.text.strip()
        else:
            return_description = ""
        
        if return_description == "See method description.":
            return_description = ""
        
        return_values_list.append({'type': return_type, 'name': return_name, 'description': return_description})
    return return_values_list

def write_lua_stub(class_name, method_string, arguments_list, return_values_list, output_directory):
    with open(os.path.join(output_directory, class_name + ".lua"), "a") as lua_file:
        # Write the parameter and return values
        for argument in arguments_list:
            lua_file.write("---@param " + argument['name'])
            if argument['optional']:
                lua_file.write("?")
            
            lua_file.write(" " + argument['type'])
            
            if argument['optional']:
                lua_file.write(" Default value: (" + argument['optional_val'] + ")")
            
            lua_file.write(" " + argument['description'] + "\n")
        for return_value in return_values_list:
            lua_file.write("---@return " + return_value['type'] + " " + return_value['name'] + " " + return_value['description'] + "\n")
        
        # Append the function signature
        lua_file.write("function ")
        if(class_name != "Global"):
            lua_file.write(class_name + ":")
        lua_file.write(method_string + "(")
        
        for i, argument in enumerate(arguments_list):
            lua_file.write(argument['name'])
            if i < len(arguments_list) - 1:
                lua_file.write(", ")
        
        lua_file.write(") end\n\n")
    
    print(f"'{method_string}' stubs appended to '{class_name}.lua'")

def write_lua_class(class_name, inherited_objects, output_directory):
    with open(os.path.join(output_directory, class_name + ".lua"), "w") as lua_file:
        lua_file.write(f"---@meta\n\n")
        if class_name != "Global":
            lua_file.write(f"---@class {class_name}")
            if inherited_objects:
                lua_file.write(f": {', '.join(inherited_objects)}")
            
            lua_file.write(f"\n{class_name} = {{}}\n\n")
        
    print(f"'{class_name}' class information appended to '{class_name}.lua'")

def process_html_file(html_file, filename, output_directory):
    with open(html_file, "r") as f:
        html = f.read()

    soup = BeautifulSoup(html, 'html.parser')
    
    # Special case for class definition files
    if filename == "index.html":
        class_name, inherited_objects   = extract_class_and_inheritance(soup)
        write_lua_class(class_name, inherited_objects, output_directory)
        return
    
    # Otherwise process like normal
    class_name, method_string           = extract_method_info(soup)
    arguments_list                      = extract_arguments(soup)
    return_values_list                  = extract_return_values(soup)
    
    write_lua_stub(class_name, method_string, arguments_list, return_values_list, output_directory)

def main():
    # Check if command-line arguments are provided
    if len(sys.argv) != 3:
        print("Usage: python parser.py <html_input_directory> <output_directory>")
        sys.exit(1)
    
    directory = sys.argv[1]
    output_directory = sys.argv[2]
    
    # Special case to process our class definitions
    html_file = os.path.join(directory, "index.html")
    process_html_file(html_file, "index.html", output_directory)
    
    # Iterate through HTML files in the directory
    for filename in os.listdir(directory):
        if filename.endswith(".html") and filename != "index.html":
            html_file = os.path.join(directory, filename)
            process_html_file(html_file, filename, output_directory)

if __name__ == "__main__":
    main()
