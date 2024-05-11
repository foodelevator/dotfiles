{ config, pkgs, profiles, ... }:
{
  environment.systemPackages = with pkgs; [ lazygit ];
  environment.variables = {
    LG_CONFIG_FILE = pkgs.writeText "lazygit.yaml" ''
      git:
        autoFetch: false
      customCommands:
        - key: '<c-p>'
          description: "Push to a specific remote repository"
          context: 'global'
          loadingText: 'Pushing ...'
          prompts:
            - type: 'menuFromCommand'
              title: 'Which remote repository to push to?'
              command: bash -c "git remote --verbose | grep '(push)$'"
              filter: '(?P<remote>[^\s]*)\s+(?P<url>[^\s]*) \(push\)'
              valueFormat: '{{ .remote }}'
              labelFormat: '{{ .remote | bold | cyan }} {{ .url }}'
            - type: 'menu'
              title: 'How to push?'
              options:
                - value: 'push'
                - value: 'push --force-with-lease'
                - value: 'push --force'
          command: "git {{index .PromptResponses 1}} {{index .PromptResponses 0 | quote}}"
    '';
  };
}
