{
  name = "maid";
  # write lots of scripts based on the current lib directory
  # TODO writeScript <name> and <script>
  # such as bin/<name>
  # #!/usr/bin/env bash
  # set -e
  # PATH=${0%/*/*}/libexec:$PATH server "$@"

  # and libexec/<name>-<cmd>

  # #!/usr/bin/env bash
  #
  # if [[ $2 = --help ]]; then
  #   exec "${0##*/}" help -- "$1"
  # elif command -v "${0##*/}-$1" &>/dev/null; then
  #   exec "${0##*/}-$1" "${@:2}"
  # fi

}
