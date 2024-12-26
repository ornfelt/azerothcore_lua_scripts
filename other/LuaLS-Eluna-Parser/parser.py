import os
import sys
import re
from bs4 import BeautifulSoup

debug = False

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

def extract_table(soup):
    # Extract the header row
    header = soup.find('thead')
    if header is None:
        return []
        
    header_row = header.find_all('th')
    if not header_row:
        return []
    
    # Extract the column names (keys) from the header
    headers = [header.get_text(strip=True) for header in header_row]
    
    # Find all the table rows, skipping the header
    rows = soup.find_all('tr')[1:]
    if not rows:
        return []
    
    row_list = []
    
    for row in rows:
        cells = row.find_all('td')
        if not cells:
            return []
        
        # Ensure the row has the same number of columns as the header
        if len(cells) != len(headers):
            continue  # Skip rows that don't match the header
        
        cell_data = {}
        for idx, cell in enumerate(cells):
            # Check if the cell contains any <span> elements
            if cell.find_all('span'):
                cell_data[headers[idx]] = extract_parameters(cell)
            else:
                cell_data[headers[idx]] = cell.get_text(strip=True)
        
        row_list.append(cell_data)
    
    return row_list

def extract_parameters(cell):
    parameters = {}
    
    # Find all <span> tags in the 'cell'
    spans = cell.find_all('span')
    
    # Extract the 'title' as the key and text as the value
    for span in spans:
        title = span.get('title')
        text = span.get_text(strip=True)
        if title:
            parameters[text] = title
    
    return parameters

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

def write_lua_stub(class_name, method_string, arguments_list, table_list, return_values_list, output_directory):
    with open(os.path.join(output_directory, class_name + ".lua"), "a") as lua_file:
        # Write the parameter definitions
        for argument in arguments_list:
            lua_file.write("---@param " + argument['name'])
            if argument['optional']:
                lua_file.write("?")
            
            lua_file.write(" " + argument['type'])
            
            if argument['optional']:
                lua_file.write(" Default value: (" + argument['optional_val'] + ")")
            
            lua_file.write(" " + argument['description'] + "\n")
        
        # Hard code table parsing for register events for now (function overload definitions)
        if(class_name == "Global") and re.match(r"^Register\w+Event$", method_string):
            for row in table_list:
                # Only create function overloads for properly formatted parameter data
                if 'Parameters' in row and isinstance(row['Parameters'], dict):
                    lua_file.write("---@overload fun(event: " + row['ID'] + ", func: fun(")
                    
                    # Loop through parameters and check for 'event', we want to define this as the event ID and not a type
                    params = []
                    for key, value in row['Parameters'].items():
                        if key == 'event':
                            params.append(f'{key}: {row["ID"]}')
                        else:
                            params.append(f'{key}: {value}')
                    
                    # Join the parameters and write to the file
                    lua_file.write(', '.join(params))
                    lua_file.write("), shots?: number): function\n")
        
        # Write the return value definitions
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
    
    global debug
    if debug:
        print(f"'{method_string}' stubs appended to '{class_name}.lua'")

def write_lua_class(class_name, inherited_objects, output_directory):
    with open(os.path.join(output_directory, class_name + ".lua"), "w") as lua_file:
        lua_file.write(f"---@meta\n\n")
        if class_name != "Global":
            lua_file.write(f"---@class {class_name}")
            if inherited_objects:
                lua_file.write(f": {', '.join(inherited_objects)}")
            
            lua_file.write(f"\n{class_name} = {{}}\n\n")
    
    global debug
    if debug:
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
    table_list                          = extract_table(soup)
    return_values_list                  = extract_return_values(soup)
    
    write_lua_stub(class_name, method_string, arguments_list, table_list, return_values_list, output_directory)

def main():
    # Check if command-line arguments are provided
    if len(sys.argv) < 3:
        print("Usage: python parser.py <html_input_directory> <output_directory> <debug=false>")
        sys.exit(1)
    
    directory = sys.argv[1]
    output_directory = sys.argv[2]
    
    # Debug (Optional) - Default to false if not provided
    if(sys.argv[3]):
        global debug
        debug = True if sys.argv[3].lower() == 'true' else False
    
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
