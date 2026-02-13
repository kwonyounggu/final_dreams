import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // For now, we use a custom mailto link that pre-fills the body
      // In production, you'd use an API call to EmailJS or Formspree here
      final String name = _nameController.text;
      final String message = _messageController.text;
      final String uri = 'mailto:your.email@example.com?subject=Contact from $name&body=$message';
      
      // Use your launchUrl logic from before
      debugPrint("Submitting to: $uri");
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Opening your email client...")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()),
            validator: (v) => v!.isEmpty ? "Please enter your name" : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            validator: (v) => v!.contains("@") ? null : "Enter a valid email",
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _messageController,
            maxLines: 5,
            decoration: const InputDecoration(labelText: "Message", border: OutlineInputBorder()),
            validator: (v) => v!.isEmpty ? "Please write a message" : null,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _submitForm,
              child: const Text("Send Message"),
            ),
          ),
        ],
      ),
    );
  }
}