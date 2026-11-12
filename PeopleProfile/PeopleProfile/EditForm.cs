using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PeopleProfile
{
    public partial class EditForm : Form
    {
        private Person _per;
        public event EventHandler<Person>? PersonUpdated;
        public EditForm(Person per)
        {
            InitializeComponent();
            _per = per;
            btnCancel.Click += (sender, e) => { ViewCurPerson(); };
            btnClear.Click += (sender, e) =>  { picPhoto.Image = null; };
            btnUpdate.Click += (sender, e) =>
            {
                if (int.TryParse(txtAge.Text, out var age) == false)
                {
                    MessageBox.Show("Invalid age", "Updating", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                _per.Name = txtName.Text.Trim();
                _per.Age = age;
                _per.PhotoBase64 = ImageUtitity.ConvertImageToBase64(picPhoto.Image, Person.PhotoSize);
                PersonUpdated?.Invoke(this, _per);
            };
            ViewCurPerson();
        }
        private void ViewCurPerson()
        {
            txtName.Text = _per?.Name;
            txtAge.Text = _per?.Age.ToString();
            picPhoto.Image = _per?.Photo;
            btnBrowse.Click += OnClickBrowse;
        }
        private void OnClickBrowse(object? sender, EventArgs e)
        {
            OpenFileDialog dlg = new OpenFileDialog()
            {
                Title = "Browsing for photo",
                Filter = "Phto File|*.jpg;*.bmp;*.png",
                CheckFileExists = true
            };
            var result = dlg.ShowDialog();
            if (result == DialogResult.Cancel)
            {
                return;
            }
            var photoFile = dlg.FileName;
            try
            {
                var photoImage = Image.FromFile(photoFile);
                photoImage = ImageUtitity.ResizeImage(photoImage, Person.PhotoSize);
                picPhoto.Image = photoImage;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error: {ex.Message}", "Browsing", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }
    }
}
