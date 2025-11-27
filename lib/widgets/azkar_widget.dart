import 'package:azkar_app_rehi/models/azkar_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AzkarCard extends StatelessWidget {
  final AzkarModel module;
  final Function(bool) next;
  final VoidCallback incriment;
  const AzkarCard({
    super.key,
    required this.module,
    required this.next,
    required this.incriment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 13,
            spreadRadius: 3,
            offset: Offset(0, 3),
            color: Colors.black.withOpacity(.3),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surfaceContainer,
        image: DecorationImage(
          fit: BoxFit.cover,
          isAntiAlias: true,
          image: NetworkImage(
            "https://images.unsplash.com/photo-1511091734515-e50d46c37240?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      module.content,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.amiri(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 3,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 50,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    Text(
                      module.description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(child: const Divider()),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  " ${module.currentCount} | ${module.count} ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              Expanded(child: const Divider()),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                elevation: 0,
                shape: StarBorder.polygon(),
                onPressed: () {
                  next(false);
                },
                child: Icon(Icons.fast_rewind_outlined),
              ),
              FloatingActionButton(
                elevation: 0,
                onPressed: incriment,
                // onPressed: count >= module.count
                //     ? null
                //     : () {
                //         incriment(count + 1);
                //       },
                child: Icon(Icons.fingerprint),
              ),
              FloatingActionButton(
                elevation: 0,
                shape: StarBorder.polygon(),
                onPressed: () {
                  next(true);
                },
                child: Icon(Icons.fast_forward_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
