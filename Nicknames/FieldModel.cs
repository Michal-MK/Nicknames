using System;
using System.ComponentModel;

namespace Nicknames {
	public class FieldModel : INotifyPropertyChanged {

		public static bool Setup { get; set; }

		public event PropertyChangedEventHandler PropertyChanged;

		public void Notify(string propName) {
			PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propName));
		}

		private string _fillColor = "Transparent";
		private string _content = "";
		private string _foregroundColor = "Black";

		public string ForegroundColor { get => _foregroundColor; set { _foregroundColor = value; Notify(nameof(ForegroundColor)); } }
		public string Content { get => _content; set { _content = value; Notify(nameof(Content)); } }
		public string FillColor { get => _fillColor; set { _fillColor = value; Notify(nameof(FillColor)); } }

		public void ChangeWord() {
			int index = MainWindow.Rand.Next(0, MainWindow.WordBank.Count);
			string result = MainWindow.WordBank[index];
			MainWindow.WordBank.RemoveAt(index);
			MainWindow.DeletedWords.Add(result);
			Content = result;
		}
	}
}
