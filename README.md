   ## Setup (Linux)
1) Install Lua on your system - [follow this tutorial](https://www.tecmint.com/install0lua0in-centos-ubuntu-linux)
    ```shell
   sudo apt install build-essential libreadline-dev
   mkdir lua_build
   cd lua_build
   curl -R -O http://www.lua.org/ftp/lua-5.3.4.tar.gz
   tar -zxf lua-5.3.4.tar.gz
   cd lua-5.3.4
   make linux test
   sudo make install
    ```
2) Install luarocks
   ```shell
   sudo apt install luarocks
   ```
3) Install Luajson
   ```shell
   sudo luarocks install lunajson
   ```
4) Clone this repository
   ```shell
   git clone https://github.com/cyberuser-black/AprilONeil.git
   ```
5) Build the project
   ```shell
   mkdir build
   cd build
   cmake .. && make
   ```

## Usage
1) Go into the build directory, and execute the binary
   ```shell
   cd build
   ./AprilONeil
   ```
   