using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading;
using Android.App;
using Android.Content;
using Android.Graphics;
using Android.Graphics.Drawables;
using Android.OS;
using Android.Runtime;
using Android.Views;
using Android.Widget;

namespace NicknamesBoards {
	[Activity(Label = "BoardActivity")]
	public class BoardActivity : Activity {
		protected override void OnCreate(Bundle savedInstanceState) {
			base.OnCreate(savedInstanceState);

			bool blue = Intent.GetBooleanExtra("blue", true);

			Color[] cols = new Color[4] {
				Color.Red,
				Color.Blue,
				Color.Black,
				Color.Yellow
			};

			Drawable dBlack = Resources.GetDrawable(Resource.Drawable.black_bg);
			Drawable dRed = Resources.GetDrawable(Resource.Drawable.red_bg);
			Drawable dBlue = Resources.GetDrawable(Resource.Drawable.blue_bg);
			Drawable dYellow = Resources.GetDrawable(Resource.Drawable.yellow_bg);

			List<Drawable> cc = new List<Drawable>(25);

			for (int i = 0; i < 8; i++) {
				cc.Add(dRed);
			}
			for (int i = 0; i < 9; i++) {
				cc.Add(dBlue);
			}
			for (int i = 0; i < 7; i++) {
				cc.Add(dYellow);
			}
			cc.Add(dBlack);

			if (!blue) {
				cc[10] = dRed;
			}

			Random r = new Random();


			SetContentView(Resource.Layout.board);

			Window.AddFlags(WindowManagerFlags.KeepScreenOn);

			TableLayout tl = FindViewById<TableLayout>(Resource.Id.b_table);
			tl.Post(() => {
				tl.SetMinimumHeight(tl.Width);
			});

			BindingFlags bf = BindingFlags.Public | BindingFlags.Static;
			FieldInfo[] fields= typeof(Resource.Id).GetFields(bf);
			FieldInfo[] ffs =  fields.Where(f => f.Name.StartsWith("f_") && f.Name.Contains("x")).ToArray();
			for (int i = 1; i < 6; i++) {
				for (int j = 1; j < 6; j++) {
					View v = FindViewById<View>((int)typeof(Resource.Id).GetField($"f_{i}x{j}", bf).GetValue(null));
					int rem = r.Next(0, cc.Count);
					v.Background = cc[rem];
					cc.RemoveAt(rem);
				}
			}
		}
	}
}