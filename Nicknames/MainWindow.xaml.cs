using Igor.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;

namespace Nicknames {
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window, INotifyPropertyChanged {

		public event PropertyChangedEventHandler PropertyChanged;

		public void Notify(string name) {
			PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));
		}

		public static List<string> WordBank { get; set; }
		public static List<string> ExhaustedBank { get; set; } = new List<string>();

		public static List<string> DeletedWords { get; set; } = new List<string>();



		public static Random Rand = new Random();

		public List<FieldModel> Models = new List<FieldModel>();

		public Dictionary<FieldModel, Field> Views = new Dictionary<FieldModel, Field>();

		private ICommand _cZComm;
		private ICommand _eNComm;
		private ICommand _loadComm;
		private double _sliderVal;
		private string _ignoreListWord;
		private string _selectedLang;

		public string SelectedLang { get => _selectedLang; set { _selectedLang = value; Notify(nameof(SelectedLang)); } }
		public string IgnoreListWord { get => _ignoreListWord; set { _ignoreListWord = value; Notify(nameof(IgnoreListWord)); } }
		public double SliderVal { get => _sliderVal; set { _sliderVal = value; Notify(nameof(SliderVal)); } }
		public ICommand LoadComm { get => _loadComm; set { _loadComm = value; Notify(nameof(LoadComm)); } }
		public ICommand ENComm { get => _eNComm; set { _eNComm = value; Notify(nameof(ENComm)); } }
		public ICommand CZComm { get => _cZComm; set { _cZComm = value; Notify(nameof(CZComm)); } }

		public MainWindow() {
			InitializeComponent();
			DataContext = this;

			KeyDown += MainWindow_KeyDown;
			Closing += MainWindow_Closing;

			WindowState = WindowState.Maximized;
			WindowStyle = WindowStyle.None;

			ENComm = new Command(() => SelectedLang = "EN");
			CZComm = new Command(() => SelectedLang = "CZ");

			LoadComm = new Command(() => Load());
		}

		public void Load() {
			MenuGrid.Visibility = Visibility.Collapsed;
			WordBank = new List<string>(File.ReadAllLines($"wordDB_{SelectedLang}.txt"));
			WordBank = WordBank.Where(s => s.Length <= (int)SliderVal).ToList();

			if (!string.IsNullOrWhiteSpace(IgnoreListWord)) {
				WordBank = WordBank.Where(s => !s.Contains(IgnoreListWord)).ToList();
			}

			for (int i = 0; i < 5; i++) {
				for (int j = 0; j < 5; j++) {
					Field f = new Field();
					int wordIndex = Rand.Next(0, WordBank.Count);

					FieldModel model = new FieldModel {
						FillColor = Brushes.White.ToString(),
						Content = WordBank[wordIndex]
					};

					WordBank.RemoveAt(wordIndex);
					ExhaustedBank.Add(model.Content);

					Views.Add(model, f);

					Grid.SetRow(f, i);
					Grid.SetColumn(f, j);
					f.DataContext = model;

					Root.Children.Add(f);
					Models.Add(model);
				}
			}
		}

		private void MainWindow_Closing(object sender, CancelEventArgs e) {
			List<string> words = new List<string>();
			words.AddRange(ExhaustedBank);
			words.AddRange(WordBank);
			File.WriteAllLines($"wordDB_{SelectedLang}.txt", words);
		}

		private void MainWindow_KeyDown(object sender, KeyEventArgs e) {
			if(e.Key == Key.R) {
				foreach (FieldModel model in Models) {
					int wordIndex = Rand.Next(0, WordBank.Count);
					model.Content = WordBank[wordIndex];
					ExhaustedBank.Add(model.Content);
					model.FillColor = "White";
					Views[model].index = 0;
				}
			}
		}
	}
}
