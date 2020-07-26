using Android.App;
using Android.OS;
using Android.Support.V7.App;
using Android.Runtime;
using Android.Widget;
using Android.Content;

namespace NicknamesBoards {
	[Activity(Label = "@string/app_name", Theme = "@style/AppTheme", MainLauncher = true)]
	public class MainActivity : AppCompatActivity {
		protected override void OnCreate(Bundle savedInstanceState) {
			base.OnCreate(savedInstanceState);
			Xamarin.Essentials.Platform.Init(this, savedInstanceState);

			SetContentView(Resource.Layout.activity_main);

			FindViewById<Button>(Resource.Id.button).Click += Blue;
			FindViewById<Button>(Resource.Id.button2).Click += Red;
		}

		private void Red(object sender, System.EventArgs e) {
			Intent i = new Intent(this, typeof(BoardActivity));
			i.PutExtra("blue", false);
			StartActivity(i);
		}

		private void Blue(object sender, System.EventArgs e) {
			Intent i = new Intent(this, typeof(BoardActivity));
			i.PutExtra("blue", true);
			StartActivity(i);
		}

		public override void OnRequestPermissionsResult(int requestCode, string[] permissions, [GeneratedEnum] Android.Content.PM.Permission[] grantResults) {
			Xamarin.Essentials.Platform.OnRequestPermissionsResult(requestCode, permissions, grantResults);

			base.OnRequestPermissionsResult(requestCode, permissions, grantResults);
		}
	}
}