import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payment_flow_challenge/action/event.dart';
import 'package:payment_flow_challenge/entities/ticket.dart';
import 'package:sweetalert/sweetalert.dart';

class PinView extends StatefulWidget {
  PinView({
    this.ticket,
    Key key,
  }) : super(key: key);
  final Ticket ticket;

  @override
  _PinViewState createState() {
    return _PinViewState();
  }
}

class _PinViewState extends State<PinView> {
  String text = "";

  int maxPin = 6;

  buildPinDot() {
    return Container(
      margin: EdgeInsets.only(top: 48, bottom: 60),
      alignment: Alignment.center,
      child: Row(
        children: List.generate(maxPin, (index) {
          return Container(
            margin: EdgeInsets.all(12),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
                color: index < text.length ? Colors.white : null,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(12))),
          );
        }),
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraint) => Stack(
              children: <Widget>[
                Positioned(
                  bottom: 120,
                  child: Container(
                    width: constraint.maxWidth,
                    child: Column(
                      children: <Widget>[
                        buildPinDot(),
                        Container(
                          height: (constraint.maxWidth * 0.8) * 4 / 3,
                          width: constraint.maxWidth * 0.8,
                          child: GridView.count(
                            crossAxisCount: 3,
                            children: List.generate(12, (index) {
                              String text;
                              Widget child;
                              Color color = Theme.of(context).primaryColor;
                              if (index < 9) {
                                text = "${index + 1}";
                                child = Text(
                                  text,
                                  style: Theme.of(context).textTheme.headline,
                                );
                              } else if (index == 10) {
                                text = "0";
                                child = Text(
                                  text,
                                  style: Theme.of(context).textTheme.headline,
                                );
                              } else if (index == 9) {
                                color = Theme.of(context).errorColor;
                                child = Icon(
                                  Icons.backspace,
                                  color: Colors.white,
                                );
                              } else if (index == 11) {
                                color = this.text.length == maxPin
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).disabledColor;
                                child = Icon(
                                  Icons.done,
                                  color: Colors.white,
                                );
                              }

                              return Container(
                                margin: EdgeInsets.all(16),
                                child: FloatingActionButton(
                                  heroTag: index == 11
                                      ? "next"
                                      : "action_${index.toString()}",
                                  backgroundColor: color,
                                  onPressed: () {
                                    setState(() {
                                      if (index < 9 || index == 10) {
                                        if (this.text.length < maxPin)
                                          this.text += text;
                                      } else if (index == 11) {
                                        if (this.text.length == maxPin) {
                                          SweetAlert.show(
                                            context,
                                            subtitle: "Payment successful!",
                                            style: SweetAlertStyle.success,
                                            confirmButtonColor:
                                                Theme.of(context).accentColor,
                                            onPress: (b) {
                                              eventBus.fire(widget.ticket);
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        }
                                      } else if (this.text.isNotEmpty &&
                                          index == 9) {
                                        this.text = this
                                            .text
                                            .substring(0, this.text.length - 1);
                                      }
                                    });
                                  },
                                  child: child,
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}