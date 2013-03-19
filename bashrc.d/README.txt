The files in this directory are bash fragments to modularize .bashrc .

They will not be automatically sourced just because they are here.
Callers should explicitly source (.) them.

If you have dependencies between them, please don't make the caller
responsible to know the proper order of calls, but source your dependency
as required.

If a dependency may be sourced at multiple places, then make sourcing
it idempotent and name it with a lib prefix (libfoo.sh).
