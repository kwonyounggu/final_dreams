class QuantumNote {
  final String title;
  final String date;
  final String theory; // The text description
  final String latexFormula; // The actual math string

  QuantumNote({
    required this.title,
    required this.date,
    required this.theory,
    required this.latexFormula,
  });
}

final List<QuantumNote> quantumNotes = [
  QuantumNote(
    title: "The Schrödinger Equation",
    date: "Feb 2026",
    theory: "Describing how the quantum state of a physical system changes with time.",
    latexFormula: r"i\hbar \frac{\partial}{\partial t} \Psi(\mathbf{r},t) = \hat{H} \Psi(\mathbf{r},t)",
  ),
  QuantumNote(
    title: "Heisenberg Uncertainty",
    date: "Jan 2026",
    theory: "The more precisely the position is determined, the less precisely the momentum is known.",
    latexFormula: r"\sigma_x \sigma_p \geq \frac{\hbar}{2}",
  ),
];