using System;
using System.Drawing;
using System.IO;

namespace PeopleProfile
{
    public class Person
    {
        public string Name { get; set; } = "";
        public int Age { get; set; } = 0;

        private string _photoBase64 = "";
        public string PhotoBase64
        {
            get => _photoBase64;
            set
            {
                _photoBase64 = value;
                if (string.IsNullOrEmpty(_photoBase64))
                {
                    _photo = null;
                }
                else
                {
                    byte[] imageBytes = Convert.FromBase64String(PhotoBase64);
                    using (MemoryStream ms = new MemoryStream(imageBytes))
                    {
                        _photo = Image.FromStream(ms);
                    }
                }
            }
        }

        private Image? _photo = null;
        public Image? Photo => _photo;

        public static Size PhotoSize => new Size() { Width = 300, Height = 200 };
    }

    public static class ImageUtility
    {
        private static string baseFolder = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Images");

        // Ensure the folder exists
        private static void EnsureFolder()
        {
            if (!Directory.Exists(baseFolder))
            {
                Directory.CreateDirectory(baseFolder);
            }
        }

        // Convert Image to Base64 and optionally save as file
        public static string ConvertImageToBase64(Image image, Size size, string? saveFileName = null)
        {
            if (image == null) return "";

            Image resizedImage = ResizeImage(image, size);

            using MemoryStream ms = new MemoryStream();
            resizedImage.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
            byte[] imageBytes = ms.ToArray();

            // Save to folder if filename is provided
            if (!string.IsNullOrEmpty(saveFileName))
            {
                EnsureFolder();
                string path = Path.Combine(baseFolder, saveFileName);
                File.WriteAllBytes(path, imageBytes);
            }

            return Convert.ToBase64String(imageBytes);
        }

        // Resize Image while maintaining aspect ratio
        public static Image ResizeImage(Image image, Size size)
        {
            int newWidth = image.Width;
            int newHeight = image.Height;

            if (newWidth > size.Width || newHeight > size.Height)
            {
                double ratioX = (double)size.Width / newWidth;
                double ratioY = (double)size.Height / newHeight;
                double ratio = Math.Min(ratioX, ratioY);

                newWidth = (int)(newWidth * ratio);
                newHeight = (int)(newHeight * ratio);
            }

            Bitmap resizedImage = new Bitmap(newWidth, newHeight);
            using Graphics g = Graphics.FromImage(resizedImage);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            g.DrawImage(image, 0, 0, newWidth, newHeight);

            return resizedImage;
        }
    }
}