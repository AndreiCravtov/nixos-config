{pkgs, ...}: {
  # Config
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-marketplace-release; [
      christian-kohler.npm-intellisense
      yoavbls.pretty-ts-errors
      svelte.svelte-vscode
      vue.volar
      wix.glean
      dbaeumer.vscode-eslint
      expo.vscode-expo-tools
      esbenp.prettier-vscode
      burkeholland.simple-react-snippets
      vercel.turbo-vsc
      antfu.vite
      vitest.explorer
      statelyai.stately-vscode

      # Tailwind CSS
      bradlc.vscode-tailwindcss
      alfredbirk.tailwind-documentation
      stivo.tailwind-fold
      kalimahapps.tailwind-config-viewer

      # GraphQL
      graphql.vscode-graphql
      graphql.vscode-graphql-syntax
    ];
  };
}
