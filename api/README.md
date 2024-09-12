# holo-backend

## Setting up development environment

Install stable Rust toolchain from [rustup.rs](https://rustup.rs).

Create `.env` file from `.env.example` and fill it with your environment variables.
Run `docker-compose.yml` to set up PostgreSQL:

```bash
docker compose up -d
```

Then install `lld` linker.

On Windows:

```powershell
cargo install -f cargo-binutils
rustup component add llvm-tools-preview
```

On Linux:

```bash
# Ubuntu
sudo apt-get install lld clang

# Arch
sudo pacman -S lld clang
```

On macOS (with brew):

```bash
brew install llvm
brew info llvm
# follow steps from terminal
```

Then you can run the project with `cargo run`.