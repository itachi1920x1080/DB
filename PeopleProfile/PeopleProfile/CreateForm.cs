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
    public partial class CreateForm : Form
    {
        public event EventHandler<Person>? PersonCreated;
        public CreateForm()
        {
            InitializeComponent();

            btnClear.Click += (sender, e) =>
            {
                txtName.Clear();
                txtAge.Clear();
                picPhoto.Image = null;
            };
            btnBrowse.Click += OnClickBrowse;
            btnCreate.Click += (sender, e) => 
            {
                if (int.TryParse(txtAge.Text, out var age) == false) 
                {
                    MessageBox.Show("Invalid age", "Creating", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                };
                var per = new Person()
                {
                    Name = txtName.Text.Trim(),
                    Age = age,
                    PhotoBase64 = ImageUtitity.ConvertImageToBase64(picPhoto.Image, Person.PhotoSize)
                };
                PersonCreated?.Invoke(this, per);
                MessageBox.Show("Successfully created", "Creating", MessageBoxButtons.OK, MessageBoxIcon.Information);
            };
           
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
