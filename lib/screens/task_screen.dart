part of 'task_controller.dart';

class _TaskView extends WidgetView<TaskScreen, _TaskScreenController> {
  const _TaskView(_TaskScreenController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWrapper(),
      appBar: const AppBarWrapper(
        title: "Tasks",
      ),
      body: FutureBuilder(
          future: state._getTasks(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: state.taskList.length,
                itemBuilder: ((context, index) {
                  return _ListItem(
                      state: state, task: state.taskList[index], index: index);
                }));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: state._handleFabPressed,
        tooltip: 'New task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TodayView extends WidgetView<TaskScreen, _TaskScreenController> {
  const _TodayView(_TaskScreenController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWrapper(),
      appBar: const AppBarWrapper(
        title: "Today",
      ),
      body: FutureBuilder(
          future: state._getTasks(dateTo: DateTime.now()),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: state.taskList.length,
                itemBuilder: ((context, index) {
                  return _ListItem(
                      state: state, task: state.taskList[index], index: index);
                }));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: state._handleFabPressed,
        tooltip: 'New task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _UpcomingView extends WidgetView<TaskScreen, _TaskScreenController> {
  const _UpcomingView(_TaskScreenController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWrapper(),
      appBar: const AppBarWrapper(
        title: "Upcoming",
      ),
      body: FutureBuilder(
          future: state._getTasks(),
          builder: (context, snapshot) {
            var grouped =
                state.taskList.groupListsBy((element) => element.date);
            return ListView(children: _buildUpcomingList(grouped, state));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: state._handleFabPressed,
        tooltip: 'New task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

List<Widget> _buildUpcomingList(Map<DateTime, List<Task>> grouped, state) {
  List<Widget> widgets = [];
  int count = 0;
  BuildContext context = NavigationService.navigatorKey.currentContext!;

  for (MapEntry group in grouped.entries) {
    widgets.add(
      Material(
        elevation: 2,
        child: Container(
          height: 50,
          color: Theme.of(context).primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
                child: Text(
                  dateFormat.format(group.key),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    for (var task in group.value) {
      widgets.add(_ListItem(state: state, task: task, index: count));
      count++;
    }
    widgets.add(const SizedBox(
      height: 16,
    ));
  }
  return widgets;
}

class _ListItem extends StatefulWidget {
  const _ListItem(
      {Key? key, required this.state, required this.task, required this.index})
      : super(key: key);
  final _TaskScreenController state;
  final Task task;
  final int index;
  @override
  State<_ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<_ListItem> {
  @override
  Widget build(BuildContext context) {
    var task = widget.task;
    var state = widget.state;
    var index = widget.index;

    return Dismissible(
      key: Key(task.hashCode.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.redAccent,
        alignment: AlignmentDirectional.centerEnd,
        child: const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: (direction) => state._handleOnDismissed(task, index),
      child: Card(
        child: CheckboxListTile(
          title: Text(task.title),
          subtitle: task.description != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.description!),
                  ],
                )
              : null,
          value: task.isComplete,
          tristate: false,
          onChanged: (value) => state._handleCheckboxPressed(task, value),
        ),
      ),
    );
  }
}
