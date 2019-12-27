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
	}
}
