using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace Nicknames {
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window {

		public static List<string> WordBank { get; set; }
		public static List<string> ExhaustedBank { get; set; } = new List<string>();

		public static Random Rand = new Random();

		public List<FieldModel> Models = new List<FieldModel>();

		public Dictionary<FieldModel, Field> Views = new Dictionary<FieldModel, Field>();

		public MainWindow() {
			InitializeComponent();

			KeyDown += MainWindow_KeyDown;

			WindowState = WindowState.Maximized;
			WindowStyle = WindowStyle.None;

			WordBank = new List<string>(File.ReadAllLines("wordDB.txt"));

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

		private void MainWindow_KeyDown(object sender, System.Windows.Input.KeyEventArgs e) {
			if(e.Key == System.Windows.Input.Key.R) {
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
