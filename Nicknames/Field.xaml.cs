using System.Collections.Generic;
using System.Windows.Controls;
using System.Windows.Input;

namespace Nicknames {
	/// <summary>
	/// Interaction logic for UserControl.xaml
	/// </summary>
	public partial class Field : UserControl {

		public FieldModel Model => DataContext as FieldModel;

		public Field() {
			InitializeComponent();
		}

		public int index = 0;
		private Dictionary<int, string> colors = new Dictionary<int, string> {
			{ 0, "White" },
			{ 1, "CornflowerBlue" },
			{ 2, "Red" },
			{ 3, "Yellow" },
			{ 4, "Black" }
		};

		private void Grid_MouseLeftButtonDown(object sender, MouseButtonEventArgs e) {
			if (MainWindow.ClickMode == SingleClickMode.ChangeColour) {
				index++;
				index %= 5;
				Model.FillColor = colors[index];
			}
			else {
				Model.ChangeWord();
			}
		}
	}
}
