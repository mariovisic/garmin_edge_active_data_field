using Toybox.WatchUi as Ui;

class ActiveDataFieldView extends Ui.DataField
{
  hidden var elapsedTime = 0;

  function initialize() {
    DataField.initialize();
  }

  function compute(info) {
    elapsedTime = info.elapsedTime;
    Calculator.logInfo(info);
    Calculator.updateMode();
  }

  function onUpdate(dc) {
    Colors.backgroundColor = getBackgroundColor();
    var fieldsSelector = new FieldSelector();

    new StatusField().draw(dc, elapsedTime);
    new SecondaryFields().draw(dc, fieldsSelector.secondaryFields());

    var mainField = fieldsSelector.mainField();

    new MainFieldColor().draw(dc, mainField);
    new MainField().draw(dc, mainField);
    Grid.draw(dc);
  }
}
