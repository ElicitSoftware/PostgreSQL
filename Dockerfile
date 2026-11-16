# bookworm, not the moving default: a cluster records the C library's collation version when it
# is initialized, and a base image on a newer Debian makes every existing database warn of a
# collation version mismatch until its indexes are rebuilt.
FROM postgres:17-bookworm

    # Copy init_scripts
    COPY ./init_scripts /docker-entrypoint-initdb.d
    