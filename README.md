#  Simulador de Investimentos: Comparação de Rendimentos

Este aplicativo foi desenvolvido para a **Atividade 03** da disciplina de **Programação para Dispositivos Móveis (PDM)**. O objetivo do projeto é permitir a simulação e comparação detalhada dos rendimentos de dois investimentos distintos ao longo de um determinado período em meses.

---

##  Funcionalidades

- **Formulário de Entrada de Dados:**
  - Definição do período da simulação (em meses) compartilhado.
  - Entrada de Capital Inicial, Aporte Mensal e Taxa de Juros Mensal (%) para o **Investimento 1**.
  - Entrada de Capital Inicial, Aporte Mensal e Taxa de Juros Mensal (%) para o **Investimento 2**.
  - Tratamento automático de entradas numéricas (conversão de vírgulas para pontos).

- **Cálculos e Processamento:**
  - Cálculo de juros compostos considerando aportes mensais no início de cada período.
  - Armazenamento da evolução do patrimônio mês a mês.

- **Tela de Resultados (Comparação):**
  - Exibição em cards lado a lado do **Montante Final** e **Rendimento Total**.
  - **Gráfico Comparativo de Barras:** Visualização gráfica da diferença proporcional entre os montantes finais dos investimentos.
  - **Tabela/Lista Evolutiva (`ListView.builder`):** Comparação detalhada mês a mês destacando o maior rendimento de cada período.
  - **Nova Simulação:** Botão para retornar à tela inicial e refazer os cálculos (`Navigator.pop`).

---

## Tecnologias e Conceitos Utilizados

- **Flutter** & **Dart**
- **StatefulWidget** e **StatelessWidget** para gerenciamento de estado e interface
- **Form** e **TextFormField** com validações
- **Navigator** (Navegação imperativa entre páginas)
- **ListView.builder** para renderização performática de listas

---

## Como Rodar o Projeto na Sua Máquina

### Pré-requisitos
- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado na sua máquina.
- Google Chrome instalado ou um emulador Android configurado.
- __________________________
LiNK para video

https://youtu.be/aP9bnnxO-jA
