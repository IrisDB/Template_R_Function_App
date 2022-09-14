########################################################################################################################
# MoveApps R SDK aka co-pilot-r
########################################################################################################################

FROM rocker/geospatial:4.1.2

LABEL maintainer = "couchbits GmbH <us@couchbits.com>"

# Security Aspects
# group `staff` b/c of:
# When running rocker with a non-root user the docker user is still able to install packages.
# The user docker is member of the group staff and could write to /usr/local/lib/R/site-library.
# https://github.com/rocker-org/rocker/wiki/managing-users-in-docker
RUN useradd --create-home --shell /bin/bash moveapps --groups staff
USER moveapps:staff

WORKDIR /home/moveapps/co-pilot-r

# renv
#ENV RENV_VERSION 0.15.5
#RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
#RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
#COPY --chown=moveapps:staff co-pilot-r/r/renv.lock co-pilot-r/r/.Rprofile ./
#COPY --chown=moveapps:staff co-pilot-r/r/renv/activate.R co-pilot-r/r/renv/settings.dcf ./renv/

# copy the SDK
COPY --chown=moveapps:staff src/ ./src/
COPY --chown=moveapps:staff data/ ./data/
COPY --chown=moveapps:staff co-pilot-sdk.R RFunction.R start-process.sh ./
RUN mkdir ./data/output
# and restore the R libraries
#RUN R -e 'renv::restore()'

ENTRYPOINT ["/bin/bash"]