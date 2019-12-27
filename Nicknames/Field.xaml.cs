using System.Collections.Generic;
using System.Windows.Controls;

namespace Nicknames {
	/// <summary>
	/// Interaction logic for UserControl.xaml
	/// </summary>
	public partial class Field : UserControl {

		public FieldModel Model => DataContext as FieldModel;

		public Field() {
			InitializeComponent();
		}

		private void Grid_MouseRightButtonDown(object sender, System.Windows.Input.MouseButtonEventArgs e) {
			Model.ChangeWord();
		}

		public int index = 0;
		private Dictionary<int, string> colors = new Dictionary<int, string> {
			{ 0, "White" },
			{ 1, "CornflowerBlue" },
			{ 2, "Red" },
			{ 3, "Yellow" },
			{ 4, "Black" }
		};

		private void Grid_MouseLeftButtonDown(object sender, System.Windows.Input.MouseButtonEventArgs e) {
			index++;
			index %= 5;
			Model.FillColor = colors[index];
		}
	}
}
