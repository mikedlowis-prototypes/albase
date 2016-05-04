static const char version[] = "1.1.14";

__attribute__((__visibility__("hidden")))
const char *__libc_get_version()
{
    return version;
}
