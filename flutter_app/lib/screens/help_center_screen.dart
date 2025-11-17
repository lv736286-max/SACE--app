import 'package:flutter/material.dart';
import '../models/models.dart';
import '../utils/theme.dart';
import '../utils/widgets.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController subjectController;
  late TextEditingController messageController;

  final List<FAQ> faqs = [
    FAQ(
      question: '¿Como reportar emergencia?',
      answer:
          'Accede a la sección de reportar emergencia en el menú principal y completa el formulario con los detalles del incidente.',
    ),
    FAQ(
      question: '¿Que hacer despues de enviar una alerta?',
      answer:
          'Después de enviar una alerta, el sistema notificará a los encargados. Puedes consultar el estado en el historial de alertas.',
    ),
    FAQ(
      question: '¿Como cambiar mi contraseña?',
      answer:
          'Ve a Menú > Configuración y selecciona "Cambiar contraseña". Ingresa tu contraseña actual y la nueva.',
    ),
    FAQ(
      question: '¿Como contactar a los encargados?',
      answer:
          'Puedes contactar a los encargados directamente desde esta sección rellenando el formulario de contacto.',
    ),
  ];

  final List<bool> expandedFaq = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    subjectController = TextEditingController();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mensaje enviado exitosamente')),
    );
    // Clear form
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    subjectController.clear();
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: AppDimensions.phoneWidth,
          height: AppDimensions.phoneHeight,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimensions.cornerRadius),
                  border: Border.all(color: AppColors.border, width: 10),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppDimensions.cornerRadius),
                          topRight: Radius.circular(AppDimensions.cornerRadius),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Centro de ayuda',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'y soporte',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text('★',
                                    style: TextStyle(
                                        color: AppColors.primary, fontSize: 18)),
                                SizedBox(width: 8),
                                Text(
                                  'Preguntas frecuentes',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ...List.generate(
                              faqs.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey[300]!, width: 1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: ExpansionTile(
                                    title: Text(
                                      faqs[index].question,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onExpansionChanged: (expanded) {
                                      setState(() {
                                        expandedFaq[index] = expanded;
                                      });
                                    },
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          faqs[index].answer,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[700]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Nombre del encargado :',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            _buildTextField(nameController),
                            const SizedBox(height: 12),
                            const Text(
                              'Correo :',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            _buildTextField(emailController),
                            const SizedBox(height: 12),
                            const Text(
                              'Telefono :',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            _buildTextField(phoneController),
                            const SizedBox(height: 20),
                            const Text(
                              'Enviar mensaje de ayuda',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Asunto:',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            _buildTextField(subjectController),
                            const SizedBox(height: 12),
                            const Text(
                              'Mensaje:',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            _buildTextField(messageController, maxLines: 4),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _sendMessage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'Enviar mensaje',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'Cancelar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            const SizedBox(height: 70),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildBottomNav(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
