#  Simulador de Investimentos: Comparação de Rendimentos

Este aplicativo foi desenvolvido para a **Atividade 03** da disciplina de **Programação para Dispositivos Móveis (PDM)**. O objetivo do projeto é permitir a simulação e comparação detalhada dos rendimentos de dois investimentos distintos ao longo de um determinado período em meses.

---

##  Funcionalidades

- **Formulário de Entrada de Dados:**[cite: 6]
  - Definição do período da simulação (em meses) compartilhado[cite: 6].
  - Entrada de Capital Inicial, Aporte Mensal e Taxa de Juros Mensal (%) para o **Investimento 1**[cite: 6].
  - Entrada de Capital Inicial, Aporte Mensal e Taxa de Juros Mensal (%) para o **Investimento 2**[cite: 6].
  - Tratamento automático de entradas numéricas (conversão de vírgulas para pontos).

- **Cálculos e Processamento:**[cite: 6]
  - Cálculo de juros compostos considerando aportes mensais no início de cada período[cite: 6].
  - Armazenamento da evolução do patrimônio mês a mês[cite: 6].

- **Tela de Resultados (Comparação):**[cite: 6]
  - Exibição em cards lado a lado do **Montante Final** e **Rendimento Total**[cite: 6].
  - **Gráfico Comparativo de Barras:** Visualização gráfica da diferença proporcional entre os montantes finais dos investimentos[cite: 6].
  - **Tabela/Lista Evolutiva (`ListView.builder`):** Comparação detalhada mês a mês destacando o maior rendimento de cada período[cite: 6].
  - **Nova Simulação:** Botão para retornar à tela inicial e refazer os cálculos (`Navigator.pop`)[cite: 6].

---

## Tecnologias e Conceitos Utilizados

- **Flutter** & **Dart**[cite: 6]
- **StatefulWidget** e **StatelessWidget** para gerenciamento de estado e interface[cite: 6]
- **Form** e **TextFormField** com validações[cite: 6]
- **Navigator** (Navegação imperativa entre páginas)[cite: 6]
- **ListView.builder** para renderização performática de listas[cite: 6]

---

## Como Rodar o Projeto na Sua Máquina

### Pré-requisitos
- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado na sua máquina[cite: 6].
- Google Chrome instalado ou um emulador Android configurado[cite: 6].

### Passo a passo

1. **Clonar o repositório:**
   ```bash
   git clone [https://github.com/SEU_USUARIO/simulador_investimentos.git](https://github.com/SEU_USUARIO/simulador_investimentos.git)
