import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:michuapp/drawer.dart';
import 'package:michuapp/offer.dart';

class WelcomeBackPage extends StatelessWidget {
  const WelcomeBackPage({super.key});

  // --- Send message to backend (no local shortening/cleaning) ---
  Future<String> sendMessage(
      String userMessage, List<Map<String, String>> messages) async {
    final url =
        Uri.parse("https://ai-flutter-backend-michu.onrender.com/chat");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"messages": messages}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Return AI response as-is
      return data['choices'][0]['message']['content'] ?? "No response";
    } else {
      throw Exception("Failed to get response: ${response.body}");
    }
  }

  // --- Open AI Chat BottomSheet ---
  void openAIChat(BuildContext context) {
    List<Map<String, String>> messages = [];
    bool userScrolling = false;
    List<String> quickReplies = [
      "What is Michu?",
      "Tell me about Michu Kiyya",
      "How can I apply for a loan?"
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final TextEditingController _controller = TextEditingController();

        return StatefulBuilder(builder: (context, setState) {
          final ScrollController scrollController = ScrollController();

          void scrollToBottom({bool smooth = true}) {
            if (!scrollController.hasClients) return;
            final position = scrollController.position.maxScrollExtent;
            if (smooth) {
              scrollController.animateTo(
                position,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            } else {
              scrollController.jumpTo(position);
            }
          }

          void addMessage(Map<String, String> msg) {
            setState(() => messages.add(msg));
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await Future.delayed(const Duration(milliseconds: 80));
              if (!userScrolling) scrollToBottom(smooth: true);
            });
          }

          // --- Update quick replies dynamically ---
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

            try {
              final response = await sendMessage(text, messages);
              addMessage({"role": "assistant", "content": response});
              updateQuickReplies(response);
            } catch (e) {
              addMessage({
                "role": "assistant",
                "content": "Oops! Something went wrong. Try again."
              });
            }
          }

          // Initial welcome message
          if (messages.isEmpty) {
            const welcomeMsg =
                "Hi there! I’m Michu AI. How can I help you today?";
            addMessage({"role": "assistant", "content": welcomeMsg});
          }

          return DraggableScrollableSheet(
            initialChildSize: 0.75,
            maxChildSize: 0.95,
            minChildSize: 0.4,
            builder: (context, scrollSheetController) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF1C1C1C),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Container(
                        height: 4,
                        width: 40,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Expanded(
                        child: NotificationListener<UserScrollNotification>(
                          onNotification: (notification) {
                            final metrics = notification.metrics;
                            final maxScroll = metrics.maxScrollExtent;
                            final currentScroll = metrics.pixels;
                            userScrolling = (maxScroll - currentScroll) > 100;
                            return false;
                          },
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: messages.length,
                            padding: const EdgeInsets.only(bottom: 10),
                            itemBuilder: (context, index) {
                              final msg = messages[index];
                              final isUser = msg['role'] == 'user';
                              return AnimatedMessage(
                                  isUser: isUser, content: msg['content']!);
                            },
                          ),
                        ),
                      ),

                      // Quick Reply Buttons
                      if (quickReplies.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: quickReplies
                                .map((text) => Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: _quickButton(
                                          context, text, sendUserMessage),
                                    ))
                                .toList(),
                          ),
                        ),
                      const SizedBox(height: 10),

                      // Input + Send Button
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              style: const TextStyle(color: Colors.white),
                              textInputAction: TextInputAction.send,
                              onSubmitted: (value) => sendUserMessage(value),
                              decoration: InputDecoration(
                                hintText: "Type a message...",
                                hintStyle:
                                    TextStyle(color: Colors.grey[400]),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.grey[800],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: () => sendUserMessage(_controller.text),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.06;
    final verticalPadding = screenHeight * 0.04;
    final imageHeight = screenHeight * 0.35;
    final buttonWidth = screenWidth * 0.4;
    final buttonHeight = screenHeight * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu,
                          color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileDrawerPage()));
                      },
                    ),
                    Image.asset('lib/assets/MICHU-LOGO-2.png',
                        height: screenHeight * 0.05),
                    IconButton(
                      icon: const Icon(Icons.smart_toy,
                          color: Colors.white, size: 30),
                      onPressed: () => openAIChat(context),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                const Text(
                  'Welcome back',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: screenHeight * 0.005),
                const Text(
                  'Dawit Megerssa Gedefa',
                  style: TextStyle(
                      color: Color(0xFFFFA53E),
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Text(
                      'View Loan History',
                      style: TextStyle(
                          color: const Color(0xFF33A6FF),
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_right_alt,
                        color: Color(0xFF33A6FF), size: 22),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: Image.asset('lib/assets/loan.png',
                      height: imageHeight, fit: BoxFit.contain),
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  'You have successfully completed your loan. Would you like to reapply for a new Loan?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: screenWidth * 0.04,
                      height: 1.4),
                ),
                SizedBox(height: screenHeight * 0.05),
                Center(
                  child: SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EligibleLoanPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA53E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        'Reapply Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Quick Button Helper ---
Widget _quickButton(
    BuildContext context, String text, Function(String) onPressed) {
  return ElevatedButton(
    onPressed: () => onPressed(text),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[800],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 13),
    ),
  );
}

// --- Animated Chat Bubble ---
class AnimatedMessage extends StatefulWidget {
  final bool isUser;
  final String content;
  const AnimatedMessage(
      {super.key, required this.isUser, required this.content});

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
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              color: widget.isUser ? Colors.blue[300] : Colors.grey[700],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!widget.isUser)
                  const Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(Icons.smart_toy,
                        color: Colors.white, size: 20),
                  ),
                Flexible(
                  child: Text(widget.content,
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
