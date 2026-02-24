import 'package:flutter/material.dart';
import 'package:rutasinversionesaliaga/models/pedido_model.dart';

class OrderCardComponent extends StatefulWidget {
  final PedidoModel pedido; 
  const OrderCardComponent({super.key, required this.pedido});

  @override
  State<OrderCardComponent> createState() => _OrderCardComponentState();
}

class _OrderCardComponentState extends State<OrderCardComponent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          if (_isExpanded) _buildExpandedContent(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    // Tomamos el primer producto para el avatar del encabezado
    final primerProducto = widget.pedido.detalles.first;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PEDIDO #${widget.pedido.idPedido}", 
                style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
              ),
              _statusBadge(widget.pedido.estado), 
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(primerProducto.imagen),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  primerProducto.nombre,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF8B943E),
                  radius: 18,
                  child: Icon(_isExpanded ? Icons.close : Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const Divider(color: Colors.white10),
          // Listamos TODOS los productos del pedido
          ...widget.pedido.detalles.map((prod) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text("${prod.cantidad}x ${prod.nombre}", 
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
                ),
                Text("S/ ${prod.precio}", 
                    style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          )).toList(),
          const Divider(color: Colors.white10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("TOTAL", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text("S/ ${widget.pedido.total}", 
                style: const TextStyle(color: Color(0xFF8B943E), fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Text(widget.pedido.fecha, 
        style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11)),
    );
  }

  Widget _statusBadge(String estado) {
    Color color = (estado.toLowerCase() == "pendiente") ? Colors.orange : Colors.green;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(estado.toUpperCase(), style: TextStyle(color: color, fontSize: 9)),
    );
  }
}