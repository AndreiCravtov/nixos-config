{pkgs, ...}: {
  # Config
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace-release; [
      ms-python.python
      ms-python.autopep8
      ms-python.isort
      detachhead.basedpyright
      njpwerner.autodocstring
      batisteo.vscode-django
      wholroyd.jinja
      kevinrose.vsc-python-indent

      # Jupyter
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-slideshow
      ms-toolsai.vscode-jupyter-cell-tags
    ];
  };
}
