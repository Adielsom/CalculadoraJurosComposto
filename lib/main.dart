import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MeuSimuladorApp());
}

/// WIDGET PRINCIPAL (CONFIGURAÇÃO GERAL DO APLICATIVO)
/// Define o ponto de entrada da interface, aplicando o tema visual e a tela inicial.
class MeuSimuladorApp extends StatelessWidget {
  const MeuSimuladorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Juros Composto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const FormularioPage(),
    );
  }
}

/// 1. TELA INICIAL: FORMULÁRIO DE ENTRADA DE DADOS (StatefulWidget)
/// Utiliza StatefulWidget pois necessita manipular o estado dos campos de entrada
/// e atualizar a interface com validações dinâmicas de formulário.
class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  // Chave global responsável por validar o estado do Form
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para capturar as entradas do Investimento 1
  final _cap1Controller = TextEditingController(text: '1000');
  final _app1Controller = TextEditingController(text: '100');
  final _taxa1Controller = TextEditingController(text: '1.0');

  // Controladores de texto para capturar as entradas do Investimento 2
  final _cap2Controller = TextEditingController(text: '1000');
  final _app2Controller = TextEditingController(text: '150');
  final _taxa2Controller = TextEditingController(text: '0.8');

  // Controlador de texto para o período compartilhado em meses
  final _mesesController = TextEditingController(text: '12');

  @override
  void dispose() {
    // Libera a memória dos controladores ao descartar a tela (Boas Práticas)
    _cap1Controller.dispose();
    _app1Controller.dispose();
    _taxa1Controller.dispose();
    _cap2Controller.dispose();
    _app2Controller.dispose();
    _taxa2Controller.dispose();
    _mesesController.dispose();
    super.dispose();
  }

  /// ============================================================================
  /// LÓGICA DE CÁLCULO DE JUROS COMPOSTOS E SIMULAÇÃO MÊS A MÊS
  /// ============================================================================
  /// Lê os dados informados, converte vírgulas em pontos para evitar erros de parse,
  /// executa o laço de repetição mês a mês e navega para a tela de resultados.
  void _calcularESimular() {
    // 1. Executa as validações dos campos do formulário
    if (_formKey.currentState!.validate()) {
      final double cap1 =
          double.parse(_cap1Controller.text.replaceAll(',', '.'));
      final double app1 =
          double.parse(_app1Controller.text.replaceAll(',', '.'));
      final double taxa1 =
          double.parse(_taxa1Controller.text.replaceAll(',', '.')) / 100;

      final double cap2 =
          double.parse(_cap2Controller.text.replaceAll(',', '.'));
      final double app2 =
          double.parse(_app2Controller.text.replaceAll(',', '.'));
      final double taxa2 =
          double.parse(_taxa2Controller.text.replaceAll(',', '.')) / 100;

      final int meses = int.parse(_mesesController.text);

      // Listas dinâmicas para armazenar o saldo de cada mês
      List<double> evolucaoInv1 = [];
      List<double> evolucaoInv2 = [];

      double saldo1 = cap1;
      double saldo2 = cap2;

      double totalInvestido1 = cap1;
      double totalInvestido2 = cap2;

      // 2. Laço de simulação mês a mês
      for (int i = 1; i <= meses; i++) {
        // Cálculo do saldo mensal com aporte e juros compostos no início do mês
        saldo1 = (saldo1 + app1) * (1 + taxa1);
        saldo2 = (saldo2 + app2) * (1 + taxa2);

        totalInvestido1 += app1;
        totalInvestido2 += app2;

        // Guarda o saldo do mês atual nas listas
        evolucaoInv1.add(saldo1);
        evolucaoInv2.add(saldo2);
      }

      // 3. Navegação imperativa com Navigator.push para a tela de resultado
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultadoPage(
            meses: meses,
            montante1: saldo1,
            rendimento1: saldo1 - totalInvestido1,
            evolucao1: evolucaoInv1,
            montante2: saldo2,
            rendimento2: saldo2 - totalInvestido2,
            evolucao2: evolucaoInv2,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Investimentos'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo para período compartilhado
              const Text(
                'Período da Simulação',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _mesesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Período em meses',
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe os meses' : null,
              ),
              const SizedBox(height: 20),

              // Utilização do widget reutilizável para o Investimento 1
              _buildInvestimentoCard(
                titulo: 'Investimento 1',
                cor: Colors.blue.shade50,
                capController: _cap1Controller,
                appController: _app1Controller,
                taxaController: _taxa1Controller,
              ),

              const SizedBox(height: 16),

              // Utilização do widget reutilizável para o Investimento 2
              _buildInvestimentoCard(
                titulo: 'Investimento 2',
                cor: Colors.green.shade50,
                capController: _cap2Controller,
                appController: _app2Controller,
                taxaController: _taxa2Controller,
              ),

              const SizedBox(height: 24),

              // Botão para submeter o formulário
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: _calcularESimular,
                icon: const Icon(Icons.analytics),
                label: const Text(
                  'Comparar Investimentos',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ============================================================================
  /// MÉTODO/WIDGET REUTILIZÁVEL: CARD DE ENTRADA DE DADOS
  /// ============================================================================
  /// Reutilizado para renderizar de forma padronizada os formulários do Inv 1 e Inv 2.
  Widget _buildInvestimentoCard({
    required String titulo,
    required Color cor,
    required TextEditingController capController,
    required TextEditingController appController,
    required TextEditingController taxaController,
  }) {
    return Card(
      color: cor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: capController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Capital Inicial (R\$)',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe o valor' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: appController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Aporte Mensal (R\$)',
                prefixIcon: Icon(Icons.savings),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe o valor' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: taxaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Taxa de Juros Mensal (%)',
                prefixIcon: Icon(Icons.percent),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe a taxa' : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================================================
/// 2. TELA DE RESULTADOS: RESUMO, GRÁFICO E LISTA COMPARATIVA (StatelessWidget)
/// ============================================================================
/// Recebe os dados simulados por parâmetro e exibe a comparação completa.
class ResultadoPage extends StatelessWidget {
  final int meses;
  final double montante1;
  final double rendimento1;
  final List<double> evolucao1;

  final double montante2;
  final double rendimento2;
  final List<double> evolucao2;

  const ResultadoPage({
    super.key,
    required this.meses,
    required this.montante1,
    required this.rendimento1,
    required this.evolucao1,
    required this.montante2,
    required this.rendimento2,
    required this.evolucao2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado da Comparação'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Resumo Comparativo lado a lado
            Row(
              children: [
                Expanded(
                  child: _buildResumoCard(
                    'Investimento 1',
                    montante1,
                    rendimento1,
                    Colors.blue.shade100,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildResumoCard(
                    'Investimento 2',
                    montante2,
                    rendimento2,
                    Colors.green.shade100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Gráfico Comparativo Visual Simples (Funcionalidade Extra)
            GraficoComparativoWidget(
              montante1: montante1,
              montante2: montante2,
            ),
            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Evolução Mês a Mês:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            // Cabeçalho da tabela comparativa
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              color: Colors.grey.shade300,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mês', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Inv. 1 (R\$)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Inv. 2 (R\$)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Lista rolável comparativa dos rendimentos mês a mês (ListView.builder)
            Expanded(
              child: ListView.builder(
                itemCount: meses,
                itemBuilder: (context, index) {
                  final int mes = index + 1;
                  final double val1 = evolucao1[index];
                  final double val2 = evolucao2[index];

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$mesº'),
                        Text(
                          'R\$ ${val1.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: val1 >= val2
                                ? Colors.blue.shade800
                                : Colors.black,
                            fontWeight: val1 >= val2
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Text(
                          'R\$ ${val2.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: val2 >= val1
                                ? Colors.green.shade800
                                : Colors.black,
                            fontWeight: val2 >= val1
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Botão para retornar à tela inicial (Nova Simulação)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.refresh),
              label: const Text('Nova Simulação'),
            ),
          ],
        ),
      ),
    );
  }

  /// ============================================================================
  /// WIDGET REUTILIZÁVEL: CARD DE RESUMO FINAL
  /// ============================================================================
  Widget _buildResumoCard(
      String titulo, double montante, double rendimento, Color cor) {
    return Card(
      color: cor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Montante Final:', style: TextStyle(fontSize: 12)),
            Text(
              'R\$ ${montante.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('Rendimento:', style: TextStyle(fontSize: 12)),
            Text(
              'R\$ ${rendimento.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================================================
/// COMPONENTE DE GRÁFICO COMPARATIVO VISUAL 
/// ============================================================================
/// Exibe barras horizontais proporcionais para comparar visualmente os montantes finais.
class GraficoComparativoWidget extends StatelessWidget {
  final double montante1;
  final double montante2;

  const GraficoComparativoWidget({
    super.key,
    required this.montante1,
    required this.montante2,
  });

  @override
  Widget build(BuildContext context) {
    // Determina o maior valor entre os dois montantes para servir como 100% da largura do gráfico
    final double maxVal = max(montante1, montante2);
    final double pct1 = maxVal > 0 ? (montante1 / maxVal) : 0;
    final double pct2 = maxVal > 0 ? (montante2 / maxVal) : 0;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comparação de Montante Final (Gráfico):',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Barra Investimento 1
            const Text('Investimento 1', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: 20,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: constraints.maxWidth * pct1,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 8),

            // Barra Investimento 2
            const Text('Investimento 2', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: 20,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: constraints.maxWidth * pct2,
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
