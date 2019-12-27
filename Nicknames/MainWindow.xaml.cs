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

		public static HashSet<string> WordBank { get; set; }
		public static HashSet<string> ExhaustedBank { get; set; }


		public MainWindow() {
			InitializeComponent();
			Random r = new Random(DateTime.Now.Millisecond);

			WordBank = new HashSet<string>(File.ReadAllLines("wordDB.txt"));

			List<string> words = WordBank.ToList();

			for (int i = 0; i < 5; i++) {
				for (int j = 0; j < 5; j++) {
					Field f = new Field();

					FieldModel model = new FieldModel {
						FillColor = Brushes.White.ToString(),
						Content = words[r.Next(0,words.Count)]
					};

					Grid.SetRow(f, i);
					Grid.SetColumn(f, j);
					f.DataContext = model;

					Root.Children.Add(f);
				}
			}
		}
	}
}
