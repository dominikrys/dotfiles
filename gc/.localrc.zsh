# Remove nvm prom p10k
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    status                  # exit code of the last command
    command_execution_time  # duration of the last command
    background_jobs         # presence of background jobs
    direnv                  # direnv status (https://direnv.net/)
    asdf                    # asdf version manager (https://github.com/asdf-vm/asdf)
    virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
    anaconda                # conda environment (https://conda.io/)
    pyenv                   # python environment (https://github.com/pyenv/pyenv)
    goenv                   # go environment (https://github.com/syndbg/goenv)
    nodenv                  # node.js version from nodenv (https://github.com/nodenv/nodenv)
    # nvm                     # node.js version from nvm (https://github.com/nvm-sh/nvm)
    nodeenv                 # node.js environment (https://github.com/ekalinin/nodeenv)
    # node_version          # node.js version
    # go_version            # go version (https://golang.org)
    # rust_version          # rustc version (https://www.rust-lang.org)
    # dotnet_version        # .NET version (https://dotnet.microsoft.com)
    # php_version           # php version (https://www.php.net/)
    # laravel_version       # laravel php framework version (https://laravel.com/)
    # java_version          # java version (https://www.java.com/)
    # package               # name@version from package.json (https://docs.npmjs.com/files/package.json)
    rbenv                   # ruby version from rbenv (https://github.com/rbenv/rbenv)
    rvm                     # ruby version from rvm (https://rvm.io)
    fvm                     # flutter version management (https://github.com/leoafarias/fvm)
    luaenv                  # lua version from luaenv (https://github.com/cehoffman/luaenv)
    jenv                    # java version from jenv (https://github.com/jenv/jenv)
    plenv                   # perl version from plenv (https://github.com/tokuhirom/plenv)
    phpenv                  # php version from phpenv (https://github.com/phpenv/phpenv)
    scalaenv                # scala version from scalaenv (https://github.com/scalaenv/scalaenv)
    haskell_stack           # haskell version from stack (https://haskellstack.org/)
    kubecontext             # current kubernetes context (https://kubernetes.io/)
    terraform               # terraform workspace (https://www.terraform.io)
    aws                     # aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
    aws_eb_env              # aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/)
    azure                   # azure account name (https://docs.microsoft.com/en-us/cli/azure)
    gcloud                  # google cloud cli account and project (https://cloud.google.com/)
    google_app_cred         # google application credentials (https://cloud.google.com/docs/authentication/production)
    context                 # user@hostname
    nordvpn                 # nordvpn connection status, linux only (https://nordvpn.com/)
    ranger                  # ranger shell (https://github.com/ranger/ranger)
    nnn                     # nnn shell (https://github.com/jarun/nnn)
    vim_shell               # vim shell indicator (:sh)
    midnight_commander      # midnight commander shell (https://midnight-commander.org/)
    nix_shell               # nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html)
    # vi_mode               # vi mode (you don't need this if you've enabled prompt_char)
    # vpn_ip                # virtual private network indicator
    # load                  # CPU load
    # disk_usage            # disk usage
    # ram                   # free RAM
    # swap                  # used swap
    todo                    # todo items (https://github.com/todotxt/todo.txt-cli)
    timewarrior             # timewarrior tracking status (https://timewarrior.net/)
    taskwarrior             # taskwarrior task count (https://taskwarrior.org/)
    time                    # current time
    # =========================[ Line #2 ]=========================
    newline                 # \n
    # ip                    # ip address and bandwidth usage for a specified network interface
    # public_ip             # public IP address
    # proxy                 # system-wide http/https/ftp proxy
    # battery               # internal battery
    # wifi                  # wifi speed
    # example               # example user-defined segment (see prompt_example function below)
)

# Set up tokens for packages
MY_GITHUB_TOKEN=redacted
export BUNDLER_GITHUB_API_TOKEN=$MY_GITHUB_TOKEN
export HOMEBREW_GITHUB_API_TOKEN=$MY_GITHUB_TOKEN
export ANU_GITHUB_TOKEN=$MY_GITHUB_TOKEN
export BUNDLE_RUBYGEMS__PKG__GITHUB__COM=$MY_GITHUB_TOKEN
export GITHUB_PACKAGES_TOKEN=redacted

# GitHub token for multi-gitter
export GITHUB_TOKEN=redacted

# Configure utopia deployments
export ANU_BUILDKITE_TOKEN="redacted"

# Add Poetry to path
export PATH="$HOME/.local/bin:$PATH"

# Add bin to path for downloaded binaries
export PATH="$HOME/bin:$PATH"

# Configure setting monitor settings
alias dhome='displayplacer "id:ABD7749C-8F4E-4F74-9863-AADC697B1A90 res:2560x1440 hz:60 color_depth:7 scaling:on origin:(0,0) degree:0" "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1728x1117 hz:120 color_depth:8 scaling:on origin:(2560,422) degree:0"'
alias doffice='displayplacer "id:A8C53458-F651-4179-ABFE-B9E10A8337A3 res:2560x1440 hz:60 color_depth:8 scaling:on origin:(0,0) degree:0" "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1728x1117 hz:120 color_depth:8 scaling:on origin:(452,1440) degree:0"'
alias doffice2='displayplacer "id:5E3FAA22-A8AE-4D91-8D80-FB6AB9132F0F res:2560x1440 hz:60 color_depth:7 enabled:true scaling:on origin:(0,0) degree:0" "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1728x1117 hz:120 color_depth:8 enabled:true scaling:on origin:(107,1440) degree:0'

# Configure GKE auth plugin for gcloud
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Add SSH key to agent (needed for Airflow)
ssh-add ~/.ssh/id_ed25519 2>/dev/null

# Add Docker to path
export PATH="$HOME/.docker/bin:$PATH"

# Install java via asdf
. ~/.asdf/plugins/java/set-java-home.zsh

# Hack to make asdf work
export PATH="/Users/drys/.asdf/shims:$PATH"

# Add extra paths to path to use updated bash
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
