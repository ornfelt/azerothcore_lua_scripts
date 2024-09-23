# WardenInject

This is an initial proof of concept for injecting a loader into the WoW 3.3.5a client using Warden. This allows us to register a rudimentary addon message loader, which again allows us to inject larger payloads.

I opted to use Eluna as the communication platform in this example, but you could always write your own loader in C++ instead. The warden patch is for TC, but you can always modify it to whatever core you use.

This is not a finished product, but it works out of the box. I have not supplied the server side code for CSMH and StatPointUI example, but the client side code needed is supplied as payloads in the injector. You can find this in the CSMH repository.

Don't ask for support, it will probably not be given. The code is likely not to be updated.
