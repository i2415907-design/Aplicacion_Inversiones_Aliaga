import 'package:flutter/material.dart';
import 'package:rutasinversionesaliaga/models/pedido_model.dart';

class OrderCardComponent extends StatefulWidget {
  final Pedido pedido;
  const OrderCardComponent({super.key, required this.pedido});

  @override
  State<OrderCardComponent> createState() => _OrderCardComponentState();
}

class _OrderCardComponentState extends State<OrderCardComponent> {
  bool _isExpanded = false;
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: [
            _buildHeader(),
            if (_isExpanded) _buildExpandedContent(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // --- Sub-Widgets internos para mantener limpio el build ---
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PEDIDO ${widget.pedido.id}",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _statusBadge(widget.pedido.status, widget.pedido.statusColor),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _miniAvatar(),
              _miniAvatar(),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: CircleAvatar(
                  backgroundColor: _isExpanded
                      ? Colors.white
                      : const Color(0xFF8B943E),
                  radius: 18,
                  child: Icon(
                    _isExpanded ? Icons.close : Icons.add,
                    color: _isExpanded ? Colors.black : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      color: Colors.white.withOpacity(0.03),
      child: Text(
        widget.pedido.fecha,
        style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: _isEditing ? _buildEditForm() : _buildDetailList(),
    );
  }

  Widget _buildDetailList() {
    return Column(
      children: [
        const Divider(color: Colors.white10),
        ...widget.pedido.productos
            .map((p) => _productRow(p, "1 unidad"))
            .toList(),
        const SizedBox(height: 15),
        _buildLocationBox(),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildLocationBox() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.white54,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.pedido.direccion,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_note, color: Color(0xFF8B943E)),
            onPressed: () => setState(() => _isEditing = true),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm() {
    return Column(
      children: [
        const Text(
          "EDITAR ENTREGA",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        _modernInput("Distrito"),
        const SizedBox(height: 15),
        _modernInput("Dirección"),
        const SizedBox(height: 15),
        _modernInput("Cod Postal"),
        const SizedBox(height: 15),
        _modernInput("Referencia"),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => setState(() => _isEditing = false),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.white38),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2ECC71),
                ),
                onPressed: () => setState(() => _isEditing = false),
                child: const Text(
                  "GUARDAR",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- MÉTODOS DE ESTILO (Helpers) ---
  Widget _statusBadge(String text, String color) {
    Color colorTemporal = Colors.black;
    if(color == "red"){
      colorTemporal = Colors.red;
    } 
    else if (color == "green"){
      colorTemporal = Colors.green;

    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colorTemporal.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorTemporal.withOpacity(0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: colorTemporal,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _miniAvatar() {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white12),
      ),
      child: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white10,
        child: Icon(Icons.shopping_bag, size: 15, color: Colors.white24),
      ),
    );
  }

  Widget _productRow(String name, String qty) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          Text(
            qty,
            style: const TextStyle(color: Colors.white30, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _modernInput(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
