#! /bin/bash
cd /srv/rails/libertysis/current/ && bin/rake bbconnect:export:all && bin/rake bbconnect:upload:all
