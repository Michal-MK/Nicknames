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
		public static List<string> ExhaustedBank { get; set; }

		public static Random Rand = new Random();

		public MainWindow() {
			InitializeComponent();

			WindowState = WindowState.Maximized;
			WindowStyle = WindowStyle.None;

			WordBank = new List<string>(File.ReadAllLines("wordDB.txt"));

			for (int i = 0; i < 5; i++) {
				for (int j = 0; j < 5; j++) {
					Field f = new Field();

					FieldModel model = new FieldModel {
						FillColor = Brushes.White.ToString(),
						Content = WordBank[Rand.Next(0, WordBank.Count)]
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
