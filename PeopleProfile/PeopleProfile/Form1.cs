using System.Linq.Expressions;

namespace PeopleProfile
{
    public partial class Form1 : Form
    {
        BindingSource bs = new();

        public Form1()
        {
            InitializeComponent();
            bs.DataSource = Program.People;
            dgvPers.DataSource = bs;
            dgvPers.Columns[nameof(Person.PhotoBase64)].Visible = false;
            dgvPers.Columns[nameof(Person.Photo)].Visible = false;

            picPhoto.SizeMode = PictureBoxSizeMode.StretchImage;

            bs.PositionChanged += (sender, e) =>
            {
                var p = bs.Current as Person;
                picPhoto.Image = p!.Photo;
            };
            btnNew.Click += (sender, e) =>
            {
                var frm = new CreateForm();
                frm.PersonCreated += (sender, e) =>
                {
                    Program.People.Add(e);
                    bs.ResetBindings(false);
                };
                frm.ShowDialog();
            };

            btnSave.Click += (sender, e) =>
            {
                try
                {
                    var stream = File.Create(Program.DataFile);
                    using (BinaryWriter bw = new BinaryWriter(stream))
                    {
                        Program.People.ForEach(p =>
                        {
                            bw.Write(p.Name);
                            bw.Write(p.Age);
                            bw.Write(p.PhotoBase64);
                        });
                    }
                    MessageBox.Show($"Successfully saved", "Saving", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Error: {ex.Message}", "Saving", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            };

            btnLoad.Click += (sender, e) =>
            {
                try
                {
                    var stream = File.OpenRead(Program.DataFile);
                    using (BinaryReader br = new BinaryReader(stream))
                    {
                        Program.People.Clear();
                        while (true)
                        {
                            try
                            {
                                var name = br.ReadString();
                                var age = br.ReadInt32();
                                var photoBase64 = br.ReadString();
                                Program.People.Add(new Person()
                                {
                                    Name = name,
                                    Age = age,
                                    PhotoBase64 = photoBase64
                                });
                            }
                            catch (EndOfStreamException)
                            {
                                bs.ResetBindings(false);
                                break;
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Error: {ex.Message}", "Loading", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                ;
            };

            btnEdit.Click += (sender, e) =>
            {
                if (bs.Current == null) return;
                var frm = new EditForm((bs.Current as Person)!);
                frm.PersonUpdated += (sender, e) =>
                {
                    bs.ResetCurrentItem();
                    picPhoto.Image = e.Photo;
                };
                frm.ShowDialog();
            };

            btnDelete.Click += (sender, e) =>
            {
                if (bs.Current == null) return;
                bs.RemoveCurrent();
                bs.ResetBindings(false);
            };
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
