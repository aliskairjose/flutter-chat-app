import 'dart:io';

import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textCrtl = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white10,
          title: Column(
            children: [
              CircleAvatar(
                maxRadius: 15,
                backgroundColor: Colors.blue.shade100,
                child: const Text('VE', style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(height: 3),
              const Text(
                'Velifer Regalado',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                ),
              )
            ],
          ),
          centerTitle: true,
          elevation: 1,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (_, i) => _messages[i],
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                ),
              ),
              const Divider(),
              Container(color: Colors.white, child: _inputChat())
            ],
          ),
        ));
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textCrtl,
                onSubmitted: _handleSubmit,
                onChanged: (String text) {
                  setState(() {
                    _isWriting = text.isNotEmpty;
                  });
                },
                decoration: const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: _focusNode,
              ),
            ),
            // Boton de enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: !Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _isWriting ? () => _handleSubmit(_textCrtl.text.trim()) : null,
                      child: const Text('Enviar'),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue.shade400),
                        child: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _isWriting ? () => _handleSubmit(_textCrtl.text.trim()) : null,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;
    final newMessage = ChatMessage(
      text: text,
      uid: '123',
      animationCtrl: AnimationController(vsync: this, duration: const Duration(milliseconds: 300)),
    );
    _textCrtl.clear();
    _focusNode.requestFocus();
    _messages.insert(0, newMessage);
    newMessage.animationCtrl.forward();
    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    // OFF Sockets

    for (var messages in _messages) {
      messages.animationCtrl.dispose();
    }
    super.dispose();
  }
}
