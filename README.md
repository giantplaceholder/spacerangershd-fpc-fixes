# What is this?

This repo contains patches that enhance [reverse-engineered version of Space Rangers HD](//github.com/pakompom/SpaceRangersHD_FPC) written in FreePascal, and provide the following features missing from the upstream:

- Windows target and host support: cross-build on any modern Linux or Windows 7 through 11
- Fixes to both Linux and Windows targets: robust build system, proper SDL integration, bug fixes
- Semi-static and semi-portable Linux target (WIP)

**NB: upstream repo also announces support for macOS targets.** I do not have any Mac computer in my posession, so I cannot verify that my changes did not break the target. If they are, and you can verifiably fix this, open a pull request. **Until then, consider that this repo DOES NOT support macOS.**

Patches can be applied against [5f491a841cbd11d2a9a6861a822a08ffa64d15f2](https://github.com/pakompom/SpaceRangersHD_FPC/tree/5f491a841cbd11d2a9a6861a822a08ffa64d15f2) of the upstream.

You also need submodules:

- okgf @ [c01aa7a168a6f1772541501074b7bba1b96550ef](//github.com/pakompom/okgf/tree/c01aa7a168a6f1772541501074b7bba1b96550ef)
- fpc_sr @ [3a1c9cfae7f7a2bb17079b2989f562dbc5728b01](//github.com/pakompom/fpc_sr/tree/3a1c9cfae7f7a2bb17079b2989f562dbc5728b01)

Those are located at `vendor/` of the upstream repo.

# Work in progress?

You bet. I began working on this during my vacation, and these changes have very limited testing. I have fixed all of the crashes I've encountered immediately, but I'm certain that there's a lot of them still lurking beneath.

# Supported OS?

This project can produce binaries for Linux and Windows. As stated above, we do not support macOS neither as a host nor a target (yet?).

Binaries have been tested and confirmed working on Windows 7 (with caveats), 10 and 11, Linux Mint 22.1 Xia, Debian Trixie and SteamOS 3.8.28.

# But upstream supports Linux now, doesn't it? Maybe it will support Windows?

Maybe, maybe not.

In any case, it does not right now, and Linux target of the upstream looks untested and contains several serious issues with SDL.

Bottom line: I had some extra time, so I decided to patch stuff up.

# But upstream has already moved further and got updated!

I know. I do not plan to blindly follow their changes. I'll take what I need from it, if I need it.

I do this for fun, not to be up-to-date.

# What has been fixed?

Apart from build system - mainly SDL integration. Now we have DPI awareness, proper windowed mode support, integer scaling support, pillar-boxed non-integer scaling, (mostly) pointer clamping across all modes, and so on and so on.

I have also fixed a couple of crashes that upstream is yet to fix, and added a bit of polish so Steam Deck trackpads would work properly too.

Windows 7 client support also required some targeted tinkering, mainly in toolchain and SDL integration, due to this OS advanced age.

Otherwise, I try not to introduce any gameplay or balance changes.

# Cross-platform support details?

Linux and Windows binaries can be built on any modern Ubuntu (24.04+), Linux Mint (22.1 Xia) or Debian (Trixie).

Additionally, you can also build this on Windows, but only for Windows target. Right now you cannot build Linux target on Windows host.

Linux binaries are produced natively, Windows build - regardless of the host OS - uses mingw64 to cross-compile.

By default, Linux builds use vendored fpc fork, but you can also build them with the system one.

I see no reason why this won't build on any other recent Linux, but you'll have to adapt dependencies from below to your distro by yourself. For instance, on Arch or CachyOS you might need to install mingw64 from AUR or extra repos.

# How to apply patches and build binaries?

This section has gotten way too big and was moved to a separate document, see [BUILD.md](docs/BUILD.md).

**NB:** an active internet connection is **REQUIRED** for Windows target builds to complete, as mingw will live-download required dependencies. First build might take a while.

**NB:** LTO builds are broken as of now, and static builds are still WIP and largely untested due to their low priority.

Be advised that if you build the binaries with a vendored fpc fork, it has to be compiled itself. This requires 4+ gigs of RAM on your build machine, for Linux and Windows alike.

# How to run the game?

You should own the game on Steam in order to play it with these binaries (GOG version is not tested but will probably work).

To launch the game, copy your binaries to the root game folder, overwrite everything and run:

- Linux: `./Rangers --game-dir=/absolute/path/to/the/game/root/directory`

For example, on Deck you can run: `./Rangers --game-dir=/home/deck/.steam/steam/steamapps/common/Space Rangers HD A War Apart`

The same will work on any Linux, just adapt the path to the directory containing game's assets.

- Windows: just double-click `Rangers.exe` and wait for the game to start.

# AI involvement?

This project began as a monolithic, single-file 100 KB patch - because I naively thought that this would be a funny vacation one-off project I won't have to support. 

Of course, this turned out to be a false thought, so I used self-hosted Qwen3.8 Flash to split the patch into a series of smaller ones. The split was then manually reviewed by me.

The same model along with Codex was also used to run target builds tests and verify their status.

Otherwise, pretty much all of the original shitty Pascal and Python code this project brings is written by a meatbag. 

# License?

License is [MIT](LICENSE).

This project was previously licensed as WTFPL, but since then I have gotten some legal advice regarding how to better release my changes. Apologies for that, but in my opinion, this really changes nothing for anyone's freedom to use this code however they want.

**PLEASE NOTE: the MIT license applies only to original material contained in this repository (meaning, the code I wrote).**

It does not grant rights in the upstream project, its dependencies or in Space Rangers HD. You agree to bear all of the legal risks originating from cloning the upstream and buiding the binaries.

This repository contains only a patch authored for Linux and Windows compatibility and some quality of life fixes. It does not contain the upstream project, ready-to-use binaries or game data. Users must independently obtain source code from the upstream project and a lawfully purchased copy of the game. I do not condone software piracy, so if you stole the game from some shady place on the internet, that's on you.

**PLEASE NOTE: this patch series is not sanctioned, endorsed or otherwise "approved" by game's developer (СНК-Games) or its publisher (1C-Softclub / Fulqrum Publishing). This is a hobby project aimed at preserving the game playable on current hardware and software.**

# Boring warranty disclaimer?

```
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
# Acknowledgements?

Upstream:
- [SpaceRangersHD_FPC](//github.com/pakompom/SpaceRangersHD_FPC) by [pakompom](https://github.com/pakompom) ([NOTICE](//github.com/pakompom/SpaceRangersHD_decomp/blob/7342a10dc1a0dcaa242ea4bc8c33e29c0eb6bdc0/NOTICE.md), [LICENSE](https://github.com/pakompom/SpaceRangersHD_decomp/blob/7342a10dc1a0dcaa242ea4bc8c33e29c0eb6bdc0/LICENSE))

