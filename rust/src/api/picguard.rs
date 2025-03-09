use image::{Rgba, RgbaImage, ImageFormat, GenericImageView, imageops};
use imageproc::drawing::draw_text_mut;
use imageproc::geometric_transformations::{rotate_about_center, Interpolation};
use ab_glyph::{FontArc, PxScale};
use glyph_brush_layout::{GlyphPositioner, Layout, SectionGeometry, SectionText, FontId};
use std::io::Cursor;
use chrono::Local;

pub struct ReturnWrapper {
    pub bytes: Vec<u8>,
    pub name: String,
}

#[flutter_rust_bridge::frb(sync)]
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(dart_async)]
pub fn add_watermark(
    bytes: &[u8], 
    name: &str, 
    watermark: &str, 
    color_value: (u8, u8, u8, u8), 
    opacity: f32,
    font_bytes: Vec<u8>, 
    font_size: Option<f32>, 
    text_gap: Option<f32>, 
    row_gap: Option<f32>,
) -> Option<ReturnWrapper> {
    // Loading pictures
    let mut img = image::load_from_memory(bytes).expect("Unable to load image");
    let (width, height) = img.dimensions();

    let text_gap = text_gap.unwrap_or(20.0);
    let row_gap = row_gap.unwrap_or(20.0);
    let font_size = font_size.unwrap_or(50.0);

    // Calculate the length of the bevel
    let hypotenuse_length = ((width.pow(2) + height.pow(2)) as f64).sqrt() as f32;

    // Loading fonts
    let font = FontArc::try_from_vec(font_bytes).expect("Unable to load font");

    // Calculate the text width of the watermark
    let px_scale = PxScale::from(font_size);
    let text_color = Rgba([color_value.1, color_value.2, color_value.3, ((color_value.0 as f32) * opacity).clamp(0.0, 255.0) as u8]);

    // Set text
    let section_text = SectionText {
        text: watermark,
        scale: px_scale,
        font_id: FontId(0),
    };

    let glyphs = Layout::default().calculate_glyphs(
        &[&font], // Font
        &SectionGeometry {
            screen_position: (0.0, 0.0),
            ..Default::default()
        },
        &[section_text]
    );

    // Calculate text width and height
    let text_width: f32 = glyphs.iter()
        .map(|g| g.glyph.position.x)  
        .sum();  // Accumulate the width of all glyphs
    let text_height: f32 = glyphs.iter()
        .map(|g| g.glyph.scale.y)  // Get the height of each glyph
        .max_by(|a, b| a.partial_cmp(b).unwrap())  // Get maximum height
        .unwrap_or(0.0);  // If there is no glyph, return 0.0

    let spaced_text_width = text_width + text_gap;
    let repeat_count = (hypotenuse_length / spaced_text_width).ceil() as usize;

    // Generate watermark text
    let repeated_text = (0..repeat_count)
        .map(|_| watermark)
        .collect::<Vec<&str>>()
        .join(" ".repeat(text_gap as usize).as_str());

    // Create a watermark layer
    let mut watermark_layer = RgbaImage::new(width, height);
    let x = (width as f32 * 0.05) as i32;
    let y = (height as f32 * 0.95) as i32;

    draw_text_mut(&mut watermark_layer, text_color, x, y, px_scale, &font, &repeated_text);

    // Rotating watermark
    let theta = (height as f32).atan2(width as f32);
    let rotated_watermark = rotate_about_center(
        &watermark_layer,
        theta,
        Interpolation::Bilinear,
        Rgba([0, 0, 0, 0])
    );

    // Overlapping watermark
    imageops::overlay(&mut img, &rotated_watermark, 0, 0);

    // Convert to PNG format
    let mut output_bytes: Vec<u8> = Vec::new();
    img.write_to(&mut Cursor::new(&mut output_bytes), ImageFormat::Png).ok()?;

    // Generate a new file name
    let timestamp = Local::now().format("%Y-%m-%d_%H-%M-%S").to_string();
    let new_name = format!("{}_{}.png", name, timestamp);

    Some(ReturnWrapper {
        bytes: output_bytes,
        name: new_name,
    })
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[cfg(test)]
mod tests {
    use std::fs;
    use super::*;

    #[test]
    fn test_add_watermark() {
        // let img_bytes = fs::read("assets/input.jpg").expect("Unable to read the picture");
        // let font_bytes = fs::read("assets/PlayfairDisplaySC-Regular.ttf").expect("Unable to read fonts");
        //
        // // Processing pictures
        // let output = add_watermark(
        //     &img_bytes,
        //     "test",
        //     "Watermark", // Watermark text
        //     (255, 0, 0, 255), // color
        //     50.0,
        //     font_bytes,    // font
        //     Some(24.0), // font size
        //     Some(30.0),
        //     Some(30.0),
        // );
        //
        // if output.is_some() {
        //     fs::write("output/output.png", output.unwrap().bytes).expect("Unable to save output image");
        // } else {
        //     println!("No value");
        // }
    }
}
