{...}:
{
  # Optional: Create a script for easier access
  home.file.".local/bin/run-deepseek".text = ''
    #!/bin/sh
    llm
  '';

  home.file.".local/bin/run-deepseek".executable = true;
}