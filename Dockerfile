# Ensure correct platform is used for multi-architecture support
FROM --platform=$TARGETPLATFORM node:22.14.0

# renovate: datasource=npm depName=tiddlywiki versioning=npm
ARG TIDDLYWIKI_VERSION=5.3.7

# Install TiddlyWiki globally
RUN npm install --location=global tiddlywiki@${TIDDLYWIKI_VERSION} && \
    tiddlywiki --version

# Add the entrypoint script
ADD tiddlywiki_or_autoinit.sh /bin

# Set environment variables
ENV WIKI_PATH /wiki
ENV DISABLE_AUTO_INIT false

# Define entrypoint and default command
ENTRYPOINT ["tiddlywiki_or_autoinit.sh"]
CMD ["--listen", "host=0.0.0.0"]
