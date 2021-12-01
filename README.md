## Overview
Here is an overview of the suggested flow charts / sequence diagrams of the project:
![April ONeil - Flow Chart Alternatives](April%20ONeil%20-%20Flow%20Chart%20Alternatives.jpg)

Here is the class diagram of the currently implemented 'Pull' architecture:
![April ONeil - Class Diagram](April%20ONeil%20-%20Class%20Diagram.jpg)
https://miro.com/app/board/uXjVOe1kCwg=/?invite_link_id=828707922228
   
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
   
