Exportando HTML5 (Web) — Mansão da Máfia
=====================================

Este documento descreve como gerar o build HTML5 do jogo e publicar no GitHub Pages (subdomínio).

1) Exportando localmente no Windows (automático)

- Execute o script PowerShell criado: `tools\export_windows.ps1` na raiz do repo (PowerShell 7 recomendado).
- O script procura o executável do Godot em `GODOT\Godot_v4.7.2-stable_win64.exe\Godot_v4.7.2-stable_win64.exe`.
- Ele tenta executar: `--export "HTML5" "docs/index.html"` usando o preset `HTML5`. Certifique-se de ter criado esse preset no Godot: `Project -> Export -> Add -> HTML5`.
- Verifique também se os templates de exportação HTML5 estão instalados no Godot (Project > Install export templates).

1) Exportando pelo editor Godot (manual)

- Abra o Godot, carregue o projeto em `GODOT/`.
- Project -> Export -> Add -> HTML5
- Configure saída para `docs/index.html` (ou outra pasta `docs/`).
- Export e copie os arquivos resultantes (index.html, .js, .wasm, assets) para a pasta `docs/` do repositório.

1) Publicando no GitHub Pages

- Este repositório já está configurado para publicar a pasta raiz da branch `main` como GitHub Pages.
- Para publicar via `docs/`, vá em Settings -> Pages e selecione branch `main` e pasta `/root` (ou escolha `docs` se preferir). Se usar `docs`, mova os arquivos para a pasta `docs/`.

1) Automatizar deploy (opcional)

- Eu incluí uma GitHub Action que publica a pasta `docs/` automaticamente quando houver alterações nesta pasta.
