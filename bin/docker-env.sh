#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_DIR="$( cd "$( dirname "${MY_DIR}/../.." )" && pwd )"

export LOGBACK_LEVEL=DEBUG
export M3_HOST_DIR="${BASE_DIR}/temp"
export M3_HOST_NAME=http://localhost
export M3_JDBC_BASE_URL="jdbc:derby://derby:1527"
export M3_JDBC_DRIVER=org.apache.derby.jdbc.ClientDriver
export M3_JDBC_NAME=Derby
  
# Annosaurus specific variables
export ANNOSAURUS_CLIENT_SECRET=foo
export ANNOSAURUS_DATABASE_DRIVER=${M3_JDBC_DRIVER}
export ANNOSAURUS_DATABASE_NAME=Derby
export ANNOSAURUS_DATABASE_PASSWORD=vars0sourceforge
export ANNOSAURUS_DATABASE_URL="${M3_JDBC_BASE_URL}/M3_ANNOTATIONS;create=true"
export ANNOSAURUS_DATABASE_URL_FOR_APPS="jdbc:derby://localhost:1527/M3_ANNOTATIONS"
export ANNOSAURUS_DATABASE_USER=varsuser
export ANNOSAURUS_HTTP_CONTEXT_PATH=/anno
export ANNOSAURUS_PORT=8082
export ANNOSAURUS_SIGNING_SECRET=bar
export ANNOSAURUS_TIMEOUT="60 seconds"
export ANNOSAURUS_ZEROMQ_ENABLE=true
export ANNOSAURUS_ZEROMQ_PORT=5563
export ANNOSAURUS_ZEROMQ_TOPIC=vars
export IMAGE_COPYRIGHT_OWNER="Creative Commons (CC)"
export JWT_ISSUER=http://www.mbari.org

# Panoptess specific variables
export PANOPTES_CLIENT_SECRET=foo
export PANOPTES_FILE_ARCHIVER="org.mbari.m3.panoptes.services.MbariDiskArchiver"
export PANOPTES_HTTP_CONTEXT_PATH=/panoptes
export PANOPTES_PORT=8085
export PANOPTES_ROOT_DIRECTORY=/framegrabs
export PANOPTES_ROOT_URL="${M3_HOST_NAME}/framegrabs"
export PANOPTES_SIGNING_SECRET=bar

# Vampire squid specific variables
export VAMPIRESQUID_CLIENT_SECRET=foo
export VAMPIRESQUID_DATABASE_DRIVER=${M3_JDBC_DRIVER}
export VAMPIRESQUID_DATABASE_NAME=${M3_JDBC_NAME}
export VAMPIRESQUID_DATABASE_PASSWORD=vars0sourceforge
# FOR RDBMS that an query across multiple databases, use the following:
# export VAMPIRESQUID_DATABASE_URL="${M3_JDBC_BASE_URL}/M3_VIDEO_ASSETS;create=true;user=m3;password=pwd"
# For RDBMS that can't query across databases, use the following:
export VAMPIRESQUID_DATABASE_URL="${M3_JDBC_BASE_URL}/M3_ANNOTATIONS;create=true"
export VAMPIRESQUID_DATABASE_USER=varsuser
export VAMPIRESQUID_HTTP_CONTEXT_PATH=/vam
export VAMPIRESQUID_PORT=8084
export VAMPIRESQUID_SIGNING_SECRET=bar

# KB Server specific variables
export VARS_KB_DATABASE_DRIVER=${M3_JDBC_DRIVER}
export VARS_KB_DATABASE_HIKARI_TEST="VALUES 1"
export VARS_KB_DATABASE_NAME=${M3_JDBC_NAME}
export VARS_KB_DATABASE_PASSWORD=pwd
export VARS_KB_DATABASE_URL="${M3_JDBC_BASE_URL}/VARS_KB;create=true"
export VARS_KB_DATABASE_URL_FOR_APPS="jdbc:derby://localhost:1527/VARS_KB"
export VARS_KB_DATABASE_USER=m3
export VARS_KBSERVER_DATABASE_ALLOW_INIT=true
export VARS_KBSERVER_HTTP_CONTEXT_PATH=/kb
export VARS_KBSERVER_PORT=8083
export VARS_QUERY_FRAME_TITLE="VARS Query"

# User server specific variables
export VARS_USER_CLIENT_SECRET=foo
export VARS_USER_HTTP_CONTEXT_PATH=/accounts
export VARS_USER_PORT=8081
export VARS_USER_SIGNING_SECRET=bar

# Charybdis server specific variables
export CHARYBDIS_PORT=8086
export CHARYBDIS_ANNOSAURUS_URL="http://annosaurus:8080${ANNOSAURUS_HTTP_CONTEXT_PATH}/v1"
export CHARYBDIS_ANNOSAURUS_TIMEOUT=PT20S
export CHARYBDIS_VAMPIRESQUID_URL="http://vampire-squid:8080${VAMPIRESQUID_HTTP_CONTEXT_PATH}/v1"
export CHARYBDIS_VAMPIRESQUID_TIMEOUT=PT20S

# Need URLs for each service for Raziel configuration
export RAZIEL_PORT=8400
export RAZIEL_HTTP_CONTEXT=/config
export RAZIEL_JWT_SIGNING_SECRET=foo
export RAZIEL_MASTER_KEY=inflatable_ducks
# export HOST_IP=$(curl -4 ifconfig.co)
export HOST_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -1)
export ANNOSAURUS_URL="http://${HOST_IP}:${ANNOSAURUS_PORT}${ANNOSAURUS_HTTP_CONTEXT_PATH}/v1"
export CHARYBDIS_URL="http://${HOST_IP}:${CHARYBDIS_PORT}"
export PANOPTES_URL="http://${HOST_IP}:${PANOPTES_PORT}${PANOPTES_HTTP_CONTEXT_PATH}/v1"
export VAMPIRE_SQUID_URL="http://${HOST_IP}:${VAMPIRESQUID_PORT}${VAMPIRESQUID_HTTP_CONTEXT_PATH}/v1"
export VARS_KB_SERVER_URL="http://${HOST_IP}:${VARS_KBSERVER_PORT}${VARS_KBSERVER_HTTP_CONTEXT_PATH}/v1"
export VARS_USER_SERVER_URL="http://${HOST_IP}:${VARS_USER_PORT}${VARS_USER_HTTP_CONTEXT_PATH}/v1"
# For docker we need urls on the m3 network
export ANNOSAURUS_INTERNAL_URL="http://annosaurus:8080${ANNOSAURUS_HTTP_CONTEXT_PATH}/v1"
export CHARYBDIS_INTERNAL_URL="http://charybdis:8080${CHARYBDIS_HTTP_CONTEXT_PATH}"
export PANOPTES_INTERNAL_URL="http://panoptes:8080${PANOPTES_HTTP_CONTEXT_PATH}/v1"
export VAMPIRE_SQUID_INTERNAL_URL="http://vampire-squid:8080${VAMPIRESQUID_HTTP_CONTEXT_PATH}/v1"
export VARS_KB_SERVER_INTERNAL_URL="http://vars-kb-server:8080${VARS_KBSERVER_HTTP_CONTEXT_PATH}/v1"
export VARS_USER_SERVER_INTERNAL_URL="http://vars-user-server:8080${VARS_USER_HTTP_CONTEXT_PATH}/v1"
# --- NOTES
#
# BASE_DIR should be defined before you source this file
#
# M3_JDBC_NAME indicates the SQL dialect used by JPA apps. Acceptable 
# values are:
# Auto, Oracle, Oracle11, Oracle10g, Oracle9i, Oracle8i, Attunity, 
# Cloudscape, Database, DB2, DB2MainFrame, DBase, Derby, HANA, HSQL,
# Informix, Informix11, JavaDB, MaxDB, MySQL4, MySQL, PointBase,
# PostgreSQL, SQLServer, Sybase, Symfoware, timesTen
#
# For Hikari test see # https://stackoverflow.com/questions/3668506/efficient-sql-test-query-or-validation-query-that-will-work-across-all-or-most
#
# vars-user-service and vars-kb-service generally run against the same 
# database. We use `VARS_KB_` env vars to store values that are shared 
# by both of these databases.
#
# PANOPTES_ROOT_DIRECTORY is where framegrags are stored relative to 
# the docker container. Map an external volume to this dir.
#
# PANOPTES_ROOT_URL is the URL that maps PANOPTES_ROOT_DIRECTORY as a
# URL.