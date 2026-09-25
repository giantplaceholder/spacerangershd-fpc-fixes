# What is this?

This repo provides support for Windows target, as well as QoL fixes to both Linux and Windows target to the [reverse-engineered version of Space Rangers HD](//github.com/pakompom/SpaceRangersHD_FPC) written in FreePascal.

Upstream repo can produce binaries only for MacOS and Linux. This patch rectifies that.

This patch can be applied against [5f491a841cbd11d2a9a6861a822a08ffa64d15f2](https://github.com/pakompom/SpaceRangersHD_FPC/tree/5f491a841cbd11d2a9a6861a822a08ffa64d15f2) of the upstream.

You also need submodules:

- okgf @ [c01aa7a168a6f1772541501074b7bba1b96550ef](//github.com/pakompom/okgf/tree/c01aa7a168a6f1772541501074b7bba1b96550ef)
- fpc_sr @ [3a1c9cfae7f7a2bb17079b2989f562dbc5728b01](//github.com/pakompom/fpc_sr/tree/3a1c9cfae7f7a2bb17079b2989f562dbc5728b01)

Those are located at `vendor/` of the upstream repo.

# Work in progress?

You bet. I cobbled this together while on vacation, so I barely tested the build. I have fixed all of the crashes I've encountered immediately, but I'm certain that there's a lot of them still lurking beneath.

Resulting binaries have been launched on Windows 10 and 11, Linux Mint 22.1 Xia and Steam Deck (whatever is current as of this second).

# But upstream supports Linux now, doesn't it? Maybe it will support Windows?

Maybe, maybe not. In any case, Linux target of the upstream looks untested and contains several serious issues with SDL.

I had some extra time, so I decided to patch stuff up.

# What has been fixed?

Apart from build system - mainly SDL integration.

Now we have DPI awareness, proper windowed mode support, integer scaling support, pillar-boxed non-integer scaling, pointer clamping (panning in 2D works now), and so on and so on.

I have also fixed a couple of crashes that upstream is yet to fix, and added a bit of polish so Steam Deck trackpads would work properly too.

Windows build has some libraries consolidated into one, so that users wouldn't freak out seeing 20+ new dlls in their game folder.

No gameplay or balance changes.

# Cross-platform support details?

Linux and Windows binaries can be built on any modern Ubuntu (24.04+) or Linux Mint (22.1 Xia). Debian Trixie should work also.

Linux binaries are produced natively, Windows build uses mingw64 to cross-compile. The latter requires an active internet connection to build, sorry for that.

By default, Linux builds use vendored fpc fork, but you can also build them with the system one.

I see no reason why this won't build on any other recent Linux, but you'll have to adapt dependencies from below to your distro by yourself.

NB: macOS builds are untested and unverified. I have no hardware to run them on, nor the desire to debug the build.

# How to apply patch and build?

- Install dependencies:

`sudo apt update && sudo apt install -y build-essential git python3 cmake make pkg-config fpc fp-compiler libsdl2-dev libogg-dev libvorbis-dev libjpeg-turbo8-dev libpng-dev zlib1g-dev libxvidcore-dev libxvidcore4 gcc-mingw-w64-x86-64 g++-mingw-w64-x86-64 binutils-mingw-w64-x86-64 mingw-w64-tools unzip wget ca-certificates clang lld`

- Clone upstream:

`git clone https://github.com/pakompom/SpaceRangersHD_FPC.git`
`cd SpaceRangersHD_FPC`
`git checkout --detach 5f491a841cbd11d2a9a6861a822a08ffa64d15f2`
`git submodule update --init --recursive`
`git -C vendor/fpc checkout --detach 3a1c9cfae7f7a2bb17079b2989f562dbc5728b01`
`git -C vendor/okgf checkout --detach c01aa7a168a6f1772541501074b7bba1b96550ef`

- Download `fixes.patch` from this repo and put it into the `SpaceRangersHD_FPC` directory.

- Run `git apply --check fixes.patch` to see if there's any issues.

- If output is empty, apply the patch: `git apply fixes.patch`

Now you can try to build binaries:

- For Linux, vendored fpc: `./tools/build.py --target linux --release`
- For Linux, system fpc: `./tools/build.py --target linux --release --system-fpc`
- For Windows: `./tools/build.py --target windows --release`

NB: an active internet connection is **REQUIRED** for Windows builds to complete, as mingw will download required dependencies. First build might take a while.

If everything compiled OK, binaries will be at:

- Linux: `SpaceRangersHD_FPC/.local/linux-x86_64/release/bin`
- Windows: `SpaceRangersHD_FPC/.local/windows-x86_64/release/bin`

Be advised that if you build the binaries with a vendored fpc fork, it has to be compiled itself. This requires 4+ gigs of RAM on your build machine, for Linux and Windows alike.

# How to run the game?

You should own the game on Steam in order to play it with these binaries (GOG version is not tested but will probably work).

To launch the game, copy your binaries to the root game folder, overwrite everything and run:

- Linux: `./Rangers --game-dir=/absolute/path/to/the/game/root/directory`

For example, on Deck you can run: `./Rangers --game-dir=/home/deck/.steam/steam/steamapps/common/Space Rangers HD A War Apart`

The same will work on any Linux, just adapt the path to the directory containing game's assets.

- Windows: just double-click `Rangers.exe` and wait for the game to start.

# License?

License is [WTFPL](LICENSE).

The WTFPL license applies only to original material contained in this repository (meaning, code I wrote).

It does not grant rights in the upstream project, its dependencies or in Space Rangers HD. You agree to bear all of the legal risks originating from cloning the upstream and buiding the binaries.

This repository contains only a patch authored for Linux and Windows compatibility and some quality of life fixes. It does not contain the upstream project, ready-to-use binaries or game data. Users must independently obtain source code from the upstream project and a lawfully purchased copy of the game. I do not condone software piracy, so if you stole the game from some shady place on the internet, that's on you.

PLEASE NOTE: this patch is not affiliated with or endorsed by game's developers or its publisher. This is a hobby project.

# Boring warranty disclaimer?

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

# Acknowledgements?

Upstream: 
- [SpaceRangersHD_FPC](//github.com/pakompom/SpaceRangersHD_FPC) by [pakompom](https://github.com/pakompom) ([NOTICE](//github.com/pakompom/SpaceRangersHD_decomp/blob/7342a10dc1a0dcaa242ea4bc8c33e29c0eb6bdc0/NOTICE.md), [LICENSE](https://github.com/pakompom/SpaceRangersHD_decomp/blob/7342a10dc1a0dcaa242ea4bc8c33e29c0eb6bdc0/LICENSE))

