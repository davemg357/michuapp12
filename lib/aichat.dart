import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// -------------------- Persistent Chat History --------------------
List<Map<String, String>> persistentMessages = [];

// -------------------- Send message to backend --------------------
Future<String> sendAIMessage(
    String userMessage, List<Map<String, String>> messages) async {
  final url = Uri.parse("https://ai-flutter-backend-michu.onrender.com/chat");
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"messages": messages}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'] ?? "No response";
  } else {
    throw Exception("Failed to get response: ${response.body}");
  }
}

// -------------------- Show AI Bottom Sheet --------------------
void showAIBottomSheet(BuildContext context) {
  List<Map<String, String>> messages = List.from(persistentMessages);
  List<String> quickReplies = [
    "What is Michu?",
    "Tell me about Michu Kiyya",
    "How can I apply for a loan?"
  ];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final TextEditingController _controller = TextEditingController();
      final ScrollController scrollController = ScrollController();

      return StatefulBuilder(builder: (context, setState) {
        final bool isDark = Theme.of(context).brightness == Brightness.dark;

        void scrollToBottom() {
          if (!scrollController.hasClients) return;
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }

        void addMessage(Map<String, String> msg) {
          setState(() => messages.add(msg));
          persistentMessages = List.from(messages);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollToBottom();
          });
        }

        void updateLastMessage(Map<String, String> newMsg) {
          setState(() {
            if (messages.isNotEmpty &&
                messages.last['role'] == 'assistant' &&
                messages.last['content'] == 'typing') {
              messages[messages.length - 1] = newMsg;
            } else {
              messages.add(newMsg);
            }
            persistentMessages = List.from(messages);
          });
        }

        void updateQuickReplies(String lastResponse) {
          List<String> newReplies = ["Tell me more", "What’s next?", "Thank you!"];
          final responseLower = lastResponse.toLowerCase();

          if (responseLower.contains("kiyya")) {
            newReplies = [
              "Who can apply for Michu Kiyya?",
              "What are the loan limits?",
              "Tell me about Michu Guyyaa"
            ];
          } else if (responseLower.contains("guyyaa")) {
            newReplies = [
              "What’s the interest rate?",
              "Is collateral needed?",
              "How fast is approval?"
            ];
          } else if (responseLower.contains("wabi")) {
            newReplies = [
              "What’s Michu Wabi?",
              "Loan limits for Wabi?",
              "How to apply for Wabi?"
            ];
          } else if (responseLower.contains("loan")) {
            newReplies = [
              "Can I repay early?",
              "What if I miss a payment?",
              "Show me all loan types"
            ];
          }

          setState(() => quickReplies = newReplies);
        }

        Future<void> sendUserMessage(String text) async {
          if (text.trim().isEmpty) return;
          FocusScope.of(context).unfocus();
          _controller.clear();

          addMessage({"role": "user", "content": text});
          addMessage({"role": "assistant", "content": "typing"}); // typing placeholder

          try {
            final response = await sendAIMessage(text, messages);
            updateLastMessage({"role": "assistant", "content": response});
            updateQuickReplies(response);
          } catch (e) {
            updateLastMessage({
              "role": "assistant",
              "content": "Oops! Something went wrong. Try again."
            });
          }
        }

        // Initial welcome message
        if (messages.isEmpty) {
          const welcomeMsg = "Hi there! I’m Michu AI. How can I help you today?";
          addMessage({"role": "assistant", "content": welcomeMsg});
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(), // close when tapped outside
          child: GestureDetector(
            onTap: () {}, // prevent closing when tapping inside
            child: DraggableScrollableSheet(
              initialChildSize: 0.75,
              maxChildSize: 0.95,
              minChildSize: 0.4,
              builder: (context, scrollSheetController) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1C1C1C) : Colors.white,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                          height: 4,
                          width: 40,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey[700] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        // --- Chat Messages List ---
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            reverse: true,
                            itemCount: messages.length,
                            padding: const EdgeInsets.only(bottom: 10),
                            itemBuilder: (context, index) {
                              final msg = messages[messages.length - 1 - index];
                              final isUser = msg['role'] == 'user';
                              final isTyping = msg['role'] == 'assistant' &&
                                  msg['content'] == 'typing';
                              final animate =
                                  !(index == messages.length - 1 && !isUser);

                              if (isTyping) {
                                return TypingIndicator(isDark: isDark);
                              }

                              return AnimatedMessage(
                                isUser: isUser,
                                content: msg['content']!,
                                animate: animate,
                                isDark: isDark,
                              );
                            },
                          ),
                        ),
                        // --- Quick Replies ---
                        if (quickReplies.isNotEmpty)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: quickReplies
                                  .map((text) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: _quickButton(context, text,
                                            sendUserMessage, isDark),
                                      ))
                                  .toList(),
                            ),
                          ),
                        const SizedBox(height: 10),
                        // --- Input Field ---
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                style: TextStyle(
                                    color:
                                        isDark ? Colors.white : Colors.black),
                                textInputAction: TextInputAction.send,
                                onSubmitted: (value) =>
                                    sendUserMessage(value),
                                decoration: InputDecoration(
                                  hintText: "Type a message...",
                                  hintStyle: TextStyle(
                                      color: isDark
                                          ? Colors.grey[400]
                                          : Colors.grey[600]),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: isDark
                                      ? Colors.grey[800]
                                      : Colors.grey[200],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.send,
                                  color:
                                      isDark ? Colors.white : Colors.black),
                              onPressed: () =>
                                  sendUserMessage(_controller.text),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      });
    },
  );
}

// -------------------- Quick Button Helper --------------------
Widget _quickButton(BuildContext context, String text,
    Function(String) onPressed, bool isDark) {
  return ElevatedButton(
    onPressed: () => onPressed(text),
    style: ElevatedButton.styleFrom(
      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    child: Text(
      text,
      style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 13),
    ),
  );
}

// -------------------- Animated Chat Bubble --------------------
class AnimatedMessage extends StatefulWidget {
  final bool isUser;
  final String content;
  final bool animate;
  final bool isDark;

  const AnimatedMessage(
      {super.key,
      required this.isUser,
      required this.content,
      this.animate = true,
      this.isDark = true});

  @override
  State<AnimatedMessage> createState() => _AnimatedMessageState();
}

class _AnimatedMessageState extends State<AnimatedMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnim;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _offsetAnim = Tween<Offset>(
      begin: Offset(widget.isUser ? 1 : -1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    return SlideTransition(
      position: _offsetAnim,
      child: FadeTransition(
        opacity: _controller,
        child: Align(
          alignment:
              widget.isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.isUser
                  ? (isDark ? Colors.blue[300] : Colors.blue[600])
                  : (isDark ? Colors.grey[700] : Colors.grey[300]),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!widget.isUser)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(Icons.smart_toy,
                        color: isDark ? Colors.white : Colors.black, size: 20),
                  ),
                Flexible(
                  child: Text(widget.content,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------- Typing Indicator Widget --------------------
class TypingIndicator extends StatefulWidget {
  final bool isDark;
  const TypingIndicator({super.key, required this.isDark});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final dotColor = isDark ? Colors.white : Colors.black;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[700] : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.smart_toy, size: 20),
            const SizedBox(width: 6),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                int activeDot = ((DateTime.now().millisecondsSinceEpoch / 300)
                            .floor() %
                        3) +
                    1;
                return Row(
                  children: List.generate(3, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Opacity(
                        opacity: i < activeDot ? 1 : 0.3,
                        child: CircleAvatar(radius: 3, backgroundColor: dotColor),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
