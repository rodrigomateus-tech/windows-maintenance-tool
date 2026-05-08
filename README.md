<div style="display: inline-block;">
  <img src="https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white" alt="Windows Badge" />
  <img src="https://img.shields.io/badge/Batch_Script-4D4D4D?style=for-the-badge&logo=windows-terminal&logoColor=white" alt="Terminal Badge" />
</div>

# ASS. COELHO — Windows Maintenance Tool v4.5

Esta é uma solução avançada de automação para manutenção e suporte técnico de estações Windows, desenvolvida para o ambiente corporativo da Assessoria Coelho. A versão 4.5 marca a transição para uma ferramenta híbrida que utiliza o poder do PowerShell e VBScript para diagnósticos precisos e execução autônoma.

---

# Evolução Técnica (v4.0 → v4.5)
Diferente das versões anteriores, a v4.5 foca em estabilidade e experiência do usuário:Auto-Elevação de Privilégios (UAC): Implementação de lógica para detectar e solicitar permissão de Administrador automaticamente.PowerShell Engine: Substituição de comandos lentos por consultas CIM/WMI via PowerShell, resultando em uma coleta de dados 80% mais rápida.  Deep Clean 2.0: Adicionada a limpeza da pasta SoftwareDistribution, resolvendo travamentos comuns de atualizações do Windows.

---

## Problema resolvido

Manutenções preventivas e corretivas eram feitas
manualmente, comando por comando, sem padronização entre
máquinas e sem registro das ações executadas. O processo
era demorado, sujeito a erro humano e sem rastreabilidade.

---

## Demonstração do Sistema

### Sistema em execução na rede local
![Sistema na rede](sistema-rede-execucao.jpg)

Execução do sistema em ambiente de rede local, demonstrando
comunicação entre máquinas e funcionamento estável após
configuração da infraestrutura.

### Interface principal do sistema
![Menu principal](menu-principal.png)

Tela inicial com os principais módulos do sistema.
Interface estruturada para navegação simples e execução
eficiente das rotinas automatizadas.

### Problema identificado
![Problema](problema-identificado.jpg)

Cenário inicial com falhas na rede e indisponibilidade
do sistema, impactando diretamente o fluxo operacional.

### Processo de otimização
![Otimização](otimizacao-rede.jpg)

Etapa de análise e implementação de melhorias, incluindo
ajustes de configuração e correção de gargalos na rede.

### Resultado após otimização
![Resultado](resultado-final.jpg)

Situação final após aplicação das melhorias, demonstrando
maior estabilidade e ganho de desempenho operacional.

---

## Módulos disponíveis

| # | Módulo | Descrição Técnica |
|---|--------|-----------|
| 1 | Info do Sistema (PS) | Coleta instantânea de CPU, RAM e Disco via PowerShell. |
| 2 | Limpeza Profunda | Remove temporários, cache e resquícios de Windows Update. |
| 3 | Reparar Windows | Execução sequencial de SFC e DISM RestoreHealth. |
| 4 | Otimização de Rede | Reset de pilha TCP/IP e Flush DNS para portais GOV.BR. |
| 5 | Fix SSD 100% | Ajuste de serviços de indexação e telemetria (SysMain/Search). |
| 6 | Suporte Contábil | Limpeza de Java e sincronização de relógio para Certificados Digitais. |
| 7 | Ferramentas de Suporte | Reinício forçado do Spooler de Impressão e Windows Explorer. |
| 8 | Verificar Disco | Winsock reset, TCP stack, DNS flush |
| 9 | Gestão de Startup | Listagem de programas que iniciam com o sistema. |
| 10 | Scanner de Vírus | Interface CLI para o Microsoft Defender. |
| 11 | Relatório Consolidado | Gera log profissional em .txt com métricas reais de hardware. |

---

## Destaques técnicos

- Verificação automática de privilégios de Administrador
- Menu interativo com navegação por input numérico
- Supressão de erros com `>nul 2>&1` para execução limpa
- Relatório gerado automaticamente com data, hora,
  nome do computador e usuário
- Módulo de Suporte Contábil específico para escritório
  contábil: resolve falhas de certificado digital causadas
  por relógio desincronizado

---

## Impacto da solução

- Redução de indisponibilidade da rede
- Automação de processos manuais de manutenção
- Melhoria na eficiência operacional
- Maior confiabilidade no ambiente corporativo
- Rastreabilidade com relatório por máquina

---

## Tecnologias utilizadas

- Batch Script (.bat): Estrutura de controle e interface de menu (CLI).
- PowerShell 5.1+: Engine de consulta de hardware e gestão de serviços.
- VBScript: Script auxiliar para elevação de UAC.
- Redes e Infraestrutura: Diagnóstico e otimização de conectividade.

---

## Como usar

1. Baixe o arquivo MaintenanceTool_v4.5.bat
2. Execute o arquivo com um duplo clique
3. O sistema solicitará permissão de administrador automaticamente
4. Escolha a opção desejada no menu interativo.

> A ferramenta verifica automaticamente se foi executada
> como administrador. Sem privilégios, exibe aviso e encerra.

---

## Autor

Desenvolvido por Rodrigo Mateus Silva  
[linkedin.com/in/rodrigo-mateus-ti](https://linkedin.com/in/rodrigo-mateus-ti)
