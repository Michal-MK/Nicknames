using System;
using System.ComponentModel;

namespace Nicknames {
	public class FieldModel : INotifyPropertyChanged {

		public event PropertyChangedEventHandler PropertyChanged;

		public void Notify(string propName) {
			PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propName));
		}

		private string _fillColor;
		private string _content;
		public string Content { get => _content; set { _content = value; Notify(nameof(Content)); } }

		public void ChangeWord() {
			throw new NotImplementedException();
		}

		public string FillColor { get => _fillColor; set { _fillColor = value; Notify(nameof(FillColor)); } }
	}
}
