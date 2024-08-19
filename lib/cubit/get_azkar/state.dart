abstract class CounterStates{}

class CounterInitialState extends CounterStates{}

class CounterPlusState extends CounterStates{
  final int counternum;
  CounterPlusState(this.counternum);
}
class CounterzeroState extends CounterStates{
  final int counternum;
  CounterzeroState(this.counternum);
}
class CounterGetDataState extends CounterStates{}
class CountercountState extends CounterStates{}



