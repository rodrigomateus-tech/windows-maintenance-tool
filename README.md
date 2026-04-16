# Windows Maintenance Tool v2.0

Ferramenta de manutenção automatizada para ambientes Windows 
corporativos, desenvolvida para a Assessoria Coelho.

## Problema resolvido
A equipe precisava executar rotinas de limpeza e reparo do 
sistema manualmente, processo sujeito a erro humano e 
inconsistente entre máquinas. A ferramenta automatizou esse 
fluxo, padronizando a manutenção em toda a frota.

## O que faz
- Limpeza de arquivos temporários e cache do sistema
- Verificação e reparo de arquivos corrompidos (sfc /scannow)
- Checagem de disco (chkdsk)
- Otimização de inicialização
- Log automático com data/hora de cada execução

## Tecnologias
- Windows Batch Script (.BAT)
- Comandos nativos Windows (sfc, chkdsk, cleanmgr, tasklist)

## Como usar
1. Execute como Administrador
2. Selecione a rotina no menu
3. Aguarde a conclusão - log salvo em /logs/

## Resultado
Implantado em ambiente real com X máquinas. Reduziu o tempo 
de manutenção manual de ~40 min para execução automatizada.

## Screenshots
