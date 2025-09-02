FROM anatolelucet/neovim:stable
WORKDIR /root/
RUN apk add git build-base curl github-cli nodejs npm
RUN mkdir -p .config/nvim
COPY . .config/nvim/
RUN nvim --headless +"Lazy install" +qall
RUN nvim --headless +"MasonToolsInstall" +qall
CMD ["nvim"]
# docker run -it -v `pwd`:/mnt/volume --workdir=/mnt/volume devhwu/nwim:0.0.1
